From: Ben Boeckel <me@benboeckel.net>
Subject: Re: [PATCH] dns: Apply a default TTL to records obtained from
 getaddrinfo()
Date: Mon, 18 May 2020 11:51:48 -0400
Message-ID: <20200518155148.GA2595638@erythro.dev.benboeckel.internal>
References: <158981176590.872823.11683683537698750702.stgit@warthog.procyon.org.uk>
Reply-To: me@benboeckel.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <158981176590.872823.11683683537698750702.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fweimer@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Mon, May 18, 2020 at 15:22:45 +0100, David Howells wrote:
> Address records obtained from getaddrinfo() don't come with any TTL
> information, even if they're obtained from the DNS, with the result that
> key.dns_resolver upcall program doesn't set an expiry time on dns_resolver
> records unless they include a component obtained directly from the DNS,
> such as an SRV or AFSDB record.
> 
> Fix this to apply a default TTL of 10mins in the event that we haven't got
> one.  This can be configured in /etc/keyutils/key.dns_resolver.conf by
> adding the line:
> 
> 	default_ttl: <number-of-seconds>
> 
> to the file.

Is there precedent for this config file format? It looks like possible
YAML, but this patch doesn't mention that anywhere. Is there a good
reason to not be using an existing format (ini, toml, json, shell-alike,
anything)? I have no preference for anything other than a format that
already exists out there. Maybe one that supports comments too so that
these settings can have context associated with them in real
deployments (which effectively rules out json)?

> +	while (fgets(buf, sizeof(buf) - 1, f)) {
> +		line++;
> +		if (buf[0] == '#')
> +			continue;

So it does support comments...

> +		p = strchr(buf, '\n');
> +		if (!p)
> +			error("%s:%u: line missing newline or too long", config_file, line);
> +		while (p > buf && isspace(p[-1]))
> +			p--;
> +		*p = 0;
> +
> +		if (strncmp(buf, "default_ttl:", 12) == 0) {
> +			p = buf + 12;
> +			while (isspace(*p))
> +				p++;

...but not if it starts with whitespace. So if one does indent the
`default_ttl` setting for whatever reason, the comment is stuck at the
first column.

> +			if (sscanf(p, "%u%n", &u, &n) != 1)
> +				error("%s:%u: default_ttl: Bad value",
> +				      config_file, line);
> +			if (p[n])
> +				error("%s:%u: default_ttl: Extra data supplied",
> +				      config_file, line);

But no trailing whitespace is allowed?

> +			if (u < 1 || u > INT_MAX)
> +				error("%s:%u: default_ttl: Out of range",
> +				      config_file, line);

The valid range should be mentioned in the docs (basically that 0 is not
allowed and has no special meaning (it could mean leaving off the TTL as
previously done)).

> +			key_expiry = u;
> +		} else {
> +			error("%s:%u: Unknown option", config_file, line);

Forwards compatibility is hard with such behavior. Is there any reason
this can't be a warning?

> @@ -24,6 +26,21 @@ It can be called in debugging mode to test its functionality by passing a
>  \fB\-D\fR flag on the command line.  For this to work, the key description and
>  the callout information must be supplied.  Verbosity can be increased by
>  supplying one or more \fB\-v\fR flags.
> +.P
> +A configuration file can be supplied to adjust various parameters.  The file
> +is looked for at:
> +.IP
> +/etc/keyutils/key.dns_resolver.conf
> +.P
> +unless otherwise specified with the \fB\-c\fR flag.
> +.P
> +Configuration options include:
> +.TP
> +.B default_ttl: <number>
> +The number of seconds to set as the expiration on a cached record.  This will
> +be overridden if the program manages to retrieve TTL information along with
> +the addresses (if, for example, it accesses the DNS directly).  The default is
> +600 seconds.

There's no mention of the leading whitespace support or comments here.
Does the file deserve its own manpage?

--Ben
