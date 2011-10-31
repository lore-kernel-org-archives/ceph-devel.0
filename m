From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 4/4] qemu/rbd: improve rbd device specification
Date: Mon, 31 Oct 2011 14:02:26 -0600
Message-ID: <4EAEFED2.70808@redhat.com>
References: <20111027083823.GD20878@redhat.com> <fc9aba44da7d8be72fabeba1caf07901aaef202d.1319836201.git.josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36540 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563Ab1JaUCd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 Oct 2011 16:02:33 -0400
In-Reply-To: <fc9aba44da7d8be72fabeba1caf07901aaef202d.1319836201.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org, berrange@redhat.com

On 10/28/2011 03:19 PM, Josh Durgin wrote:
> From: Sage Weil<sage@newdream.net>
>
> This improves the support for qemu rbd devices by adding support for a few
> key features (e.g., authentication) and cleaning up the way in which
> rbd configuration options are passed to qemu.
>
> And<auth>  member of the disk source xml specifies how librbd should

s/And/An/

> authenticate. The username attribute is the Ceph/RBD user to authenticate as.
> The usage or uuid attributes specify which secret to use. Usage is an
> arbitrary identifier local to libvirt.
>
> The old RBD support relied on setting an environment variable to
> communicate information to qemu/librbd.  Instead, pass those options
> explicitly to qemu.  Update the qemu argument parsing and tests
> accordingly.
>
> Signed-off-by: Sage Weil<sage@newdream.net>
> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
> ---
>
> This fixes the things Daniel mentioned.

Needs a v5, to fix memory management issues.

> @@ -1495,6 +1496,159 @@ qemuSafeSerialParamValue(const char *value)
>       return 0;
>   }
>
> +static int qemuBuildRBDString(virConnectPtr conn,
> +                              virDomainDiskDefPtr disk,
> +                              virBufferPtr opt)

Nit: We've been using this style:

static int
qemuBuildRBDString(virConnectPtr conn,
                    virDomainDiskDefPtr disk,
                    virBufferPtr opt)

> +        if (sec) {
> +            char *base64;
> +
> +            secret = (char *)conn->secretDriver->getValue(sec,&secret_size, 0,
> +                                                          VIR_SECRET_GET_VALUE_INTERNAL_CALL);
> +            if (secret == NULL) {
> +                qemuReportError(VIR_ERR_INTERNAL_ERROR,
> +                                _("could not get the value of the secret for username %s"),
> +                                disk->auth.username);
> +                return -1;

Resource leak.  You need to ensure virUnrefSecret(sec) gets called on 
this path.  I'd move that particular cleanup down into the cleanup: 
label, and make this part goto cleanup instead of return -1.

> +            }
> +            /* qemu/librbd wants it base64 encoded */
> +            base64_encode_alloc(secret, secret_size,&base64);
> +            virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx\\;none",
> +                            base64);

Need to check for allocation failure of base64_encode_alloc; otherwise, 
you blindly passed NULL base64 to virBufferEscape, which is not portable.

> +            VIR_FREE(base64);
> +            VIR_FREE(secret);
> +            virUnrefSecret(sec);
> +        } else {
> +            qemuReportError(VIR_ERR_INTERNAL_ERROR,
> +                            _("rbd username '%s' specified but secret not found"),
> +                            disk->auth.username);
> +            return -1;
> +        }
> +    }
> +
> +    if (disk->nhosts>  0) {
> +        virBufferStrcat(opt, ":mon_host=", NULL);
> +        for (i = 0; i<  disk->nhosts; ++i) {
> +            if (i) {
> +                virBufferStrcat(opt, "\\;", NULL);

virBufferAddLit(opt, "\\;")

is more efficient than virBufferStrcat().

> +            }
> +            if (disk->hosts[i].port) {
> +                virBufferAsprintf(opt, "%s\\:%s",
> +                                  disk->hosts[i].name,
> +                                  disk->hosts[i].port);
> +            } else {
> +                virBufferAsprintf(opt, "%s", disk->hosts[i].name);
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int qemuAddRBDHost(virDomainDiskDefPtr disk, char *hostport)
> +{
> +    char *port;
> +    int ret;
> +
> +    disk->nhosts++;
> +    ret = VIR_REALLOC_N(disk->hosts, disk->nhosts);
> +    if (ret<  0) {
> +        virReportOOMError();
> +        return -1;
> +    }
> +
> +    port = strstr(hostport, "\\:");
> +    if (port) {
> +        *port = '\0';
> +        port += 2;
> +        disk->hosts[disk->nhosts-1].port = strdup(port);
> +    } else {
> +        disk->hosts[disk->nhosts-1].port = strdup("6789");
> +    }
> +    disk->hosts[disk->nhosts-1].name = strdup(hostport);

These three strdup() need to check for allocation failure.

> +    return 0;
> +}
> +
> +/* disk->src initially has everything after the rbd: prefix */
> +static int qemuParseRBDString(virDomainDiskDefPtr disk)
> +{
> +    char *options = NULL;
> +    char *p, *e, *next;
> +
> +    p = strchr(disk->src, ':');
> +    if (p) {
> +        options = strdup(p + 1);
> +        *p = '\0';

Need to check for strdup() failure.

> +    }
> +
> +    /* options */
> +    if (!options)
> +        return 0; /* all done */
> +
> +    p = options;
> +    while (*p) {
> +        /* find : delimiter or end of string */
> +        for (e = p; *e&&  *e != ':'; ++e) {
> +            if (*e == '\\') {
> +                e++;
> +                if (*e == '\0')
> +                    break;
> +            }
> +        }
> +        if (*e == '\0') {
> +            next = e;    /* last kv pair */
> +        } else {
> +            next = e + 1;
> +            *e = '\0';
> +        }
> +
> +        if (STRPREFIX(p, "id=")) {
> +            disk->auth.username = strdup(p + strlen("id="));

Check for allocation failure.  Also, you might want to see if using 
strndup() on the original string is easier than copying the string, just 
so you can do in-place modifications of injecting NUL bytes for strdup() 
to work.

> +        }
> +        if (STRPREFIX(p, "mon_host=")) {
> +            char *h, *sep;
> +
> +            h = p + strlen("mon_host=");
> +            while (h<  e) {
> +                for (sep = h; sep<  e; ++sep) {
> +                    if (*sep == '\\'&&  (sep[1] == ',' ||
> +                                         sep[1] == ';' ||
> +                                         sep[1] == ' ')) {
> +                        *sep = '\0';
> +                        sep += 2;
> +                        break;
> +                    }
> +                }
> +                qemuAddRBDHost(disk, h);

Don't ignore the return value here.

> +                h = sep;
> +            }
> +        }
> +
> +        p = next;
> +    }
> +    return 0;
> +}
>
>   char *
>   qemuBuildDriveStr(virConnectPtr conn,
> @@ -1614,8 +1768,10 @@ qemuBuildDriveStr(virConnectPtr conn,
>                                     disk->hosts->name, disk->hosts->port);
>                   break;
>               case VIR_DOMAIN_DISK_PROTOCOL_RBD:
> -                /* TODO: set monitor hostnames */
> -                virBufferAsprintf(&opt, "file=rbd:%s,", disk->src);
> +                virBufferStrcat(&opt, "file=", NULL);

virBufferAddLit(&opt, "file=") is more efficient.

> +                if (qemuBuildRBDString(conn, disk,&opt)<  0)
> +                    goto error;
> +                virBufferStrcat(&opt, ",", NULL);

virBufferAddChar(&opt, ',') is more efficient.

> @@ -5299,10 +5418,6 @@ static int qemuStringToArgvEnv(const char *args,
>           const char *next;
>
>           start = curr;
> -        /* accept a space in CEPH_ARGS */
> -        if (STRPREFIX(curr, "CEPH_ARGS=-m ")) {
> -            start += strlen("CEPH_ARGS=-m ");
> -        }

While we aren't generating CEPH_ARGS in the environment any more, I 
don't think we should rip out the parsing code.  That is, parsing should 
be able to handle our older output, in addition to our new output.

> +++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.args
> @@ -0,0 +1,6 @@
> +LC_ALL=C PATH=/bin HOME=/home/test USER=test LOGNAME=test \
> +/usr/bin/qemu -S -M pc -m 214 -smp 1 -nographic -monitor \
> +unix:/tmp/test-monitor,server,nowait -no-acpi -boot c -drive \
> +file=/dev/HostVG/QEMUGuest1,if=ide,bus=0,unit=0 -drive \
> +file=rbd:pool/image:id=myname:key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:auth_supported=cephx\;none:mon_host=mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,\

That's a rather long line - I'd suggest using backslash-newline to break 
it up, probably at each ':' (it's not the end of the world if you go 
longer than 80 columns, if absolutely necessary, but life is easier when 
everything just fits).


> +static virSecretPtr
> +fakeSecretLookupByUsage(virConnectPtr conn,
> +                        int usageType ATTRIBUTE_UNUSED,
> +                        const char *usageID)
> +{
> +    virSecretPtr ret = NULL;
> +    int err;
> +    if (STRNEQ(usageID, "mycluster_myname"))
> +        return NULL;
> +    err = VIR_ALLOC(ret);
> +    if (err<  0)
> +        return NULL;
> +    ret->magic = VIR_SECRET_MAGIC;
> +    ret->conn = conn;
> +    conn->refs++;
> +    ret->refs = 1;
> +    ret->usageID = strdup(usageID);

Check for strdup() failure.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
