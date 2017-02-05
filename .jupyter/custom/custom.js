define([
    'base/js/namespace',
    'base/js/events'
    ],
    function(Jupyter, events) {
        events.on("app_initialized.NotebookApp",
            function () {
                // Show line numbers in cells
                Jupyter.Cell.options_default.cm_config.lineNumbers = true;

                // Wrap line
                Jupyter.Cell.options_default.cm_config.lineWrapping = true;
            }
        );
    }
);

