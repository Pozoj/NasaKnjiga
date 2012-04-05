var UploadProgressMethods = {
	uploadProgress: function(element, options) {
		options == options || {};
		options = Object.extend({
			interval: 2000,
			iframe: "",
			progressBar: "progress_bar",
			progressUrl: "/progress",
			start: function() {},
			uploading: function() {},
			complete: function() {},
			success: function() {},
			error: function() {},
      timer: ""
		}, options);

		options.iframe = document.createElement('iframe');
		options.iframe.name = "progressFrame";
		$(options.iframe).setStyle({width: '0', height: '0', position: 'absolute', top: '-3000px'});
		document.body.appendChild(options.iframe);
			
		Event.observe(element, 'submit', function(e) {
			// Generate unique UUID each time the form is submitted.
			var uuid = "";
			for (i = 0; i < 32; i++) { uuid += Math.floor(Math.random() * 16).toString(16); }
			options.uuid = uuid;
			
			// Start callback.
			options.start();
			
			// Patch the form-action tag to include the progress-id if X-Progress-ID has been already added just replace it.
      if( old_id = /X-Progress-ID=([^&]+)/.exec($(this).readAttribute("action")) )
      {
        var action = $(this).readAttribute("action").replace(old_id[1], uuid);
        $(this).writeAttribute("action", action);
      } 
      else 
      {
        // Set the hidden field.
			  $("X-Progress-ID").value = uuid;
			  $(this).writeAttribute("action", $(this).readAttribute("action") + "?X-Progress-ID=" + uuid);
			  // Set the target of the form to the created iframe.
			  $(this).writeAttribute("target", options.iframe.name);
			}
			
			// Commence periodic AJAX calls for monitoring progress.
			options.timer = window.setInterval(function() { Prototype.uploadProgress(this, options) }, options.interval);
		});
	}
};

// Decorate elements with the uploadProgress() method, for unobtrousively attaching it to forms.
Element.addMethods(UploadProgressMethods);

PrototypeUploadProgressMethods = {
	uploadProgress: function(element, options) {
		new Ajax.Request(options.progressUrl, {
			method: 'get',
			parameters: 'X-Progress-ID='+ options.uuid,
			onSuccess: function(xhr) {
				var upload = xhr.responseText.evalJSON();
				upload.percents = Math.floor((upload.received / upload.size)*100);
				if (upload.state == 'uploading') {
					var bar = $(options.progressBar);
  				bar.setStyle({width: Math.floor(upload.percents) + '%'});
  				// Localize this string.
  				$("progress_bar_caption").update("Nalagam..." + upload.percents + "%");
					options.uploading(upload);
				}
        // When done, stop the interval.
				if (upload.state == 'done' || upload.state == 'error') {
					window.clearTimeout(options.timer);
					options.complete(upload);
				}
				
				if (upload.state == 'done') {
					options.success(upload);
				}
				
				if (upload.state == 'error') {
					options.error(upload);
				}
			}
		});
	}
};

Object.extend(Prototype, PrototypeUploadProgressMethods);