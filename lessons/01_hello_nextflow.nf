nextflow.enable.dsl = 2  // Use the current Nextflow DSL2 syntax.

/*
 * This is the first course workflow.
 *
 * A Nextflow process describes one reproducible task.
 * This process creates a small text file.
 */

params.outdir = "${projectDir}/outputs/"

process SAY_HELLO {  // Define a process named SAY_HELLO.

    publishDir params.outdir, mode: 'copy'

    output:
    path "hello_nextflow.txt"  // Declare the file the process must create.

    script:
    """
    echo "This is my first reproducible output" > hello_nextflow.txt  # Write the message to the file.
    """
}

/*
 * The workflow block tells Nextflow which process to execute.
 */
workflow {

    SAY_HELLO()  // Run the SAY_HELLO process.
}
