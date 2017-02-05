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

                // Add Buttons
                Jupyter.toolbar.add_buttons_group([
                    {
                        'label'   : 'Restart & Run All',
                        'icon'    : 'fa-refresh',
                        'callback': function () {
                            Jupyter.toolbar.actions.call('jupyter-notebook:confirm-restart-kernel-and-run-all-cells')
                        }
                    },
                    {
                        'label'   : 'Restart & Clear Output',
                        'icon'    : 'fa-eraser',
                        'callback': function () {
                            Jupyter.toolbar.actions.call('jupyter-notebook:confirm-restart-kernel-and-clear-output')
                        }
                    },
                    // add more button here if needed.
                ]);

                // Hide header
                //Jupyter.toolbar.actions.call('jupyter-notebook:toggle-header')

                // Hide toolbar
                //Jupyter.toolbar.actions.call('jupyter-notebook:toggle-toolbar')

            }
        );
    }
);

