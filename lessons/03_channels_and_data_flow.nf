nextflow.enable.dsl = 2

process CREATE_CASE_REPORT {
    tag "U13824"

    input:
    path context_file

    output:
    path "upec_case_report.txt", emit: report

    script:
    """
    echo "UPEC Teaching Case" > upec_case_report.txt
    cat ${context_file} >> upec_case_report.txt
    """
}

process ADD_REPRODUCIBILITY_NOTE {
    tag "final report"

    input:
    path case_report

    output:
    path "upec_final_report.txt"

    script:
    """
    cat ${case_report} > upec_final_report.txt
    echo "Generated with Nextflow." >> upec_final_report.txt
    """
}

workflow {
    context_ch = channel.fromPath(
        "${projectDir}/upec_context.txt",
        checkIfExists: true
    )

    CREATE_CASE_REPORT(context_ch)

    ADD_REPRODUCIBILITY_NOTE(CREATE_CASE_REPORT.out.report)
}
