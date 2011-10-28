From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [libvirt] [RFC PATCH v3 2/4] storage: add auth to virDomainDiskDef
Date: Fri, 28 Oct 2011 12:15:10 -0700
Message-ID: <4EAAFF3E.6070703@dreamhost.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>	<24e32a383e9e614a3d192fa709e73c22a069ce9e.1319072460.git.josh.durgin@dreamhost.com>	<20111027083301.GB20878@redhat.com> <4EAAFA1B.6080706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56616 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab1J1TPK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 15:15:10 -0400
In-Reply-To: <4EAAFA1B.6080706@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 10/28/2011 11:53 AM, Eric Blake wrote:
> On 10/27/2011 02:33 AM, Daniel P. Berrange wrote:
>> On Thu, Oct 20, 2011 at 11:01:25AM -0700, Josh Durgin wrote:
>>> Add additional fields to let you specify the how to authenticate with
>>> a disk.
>>> The secret to use may be referenced by a usage string or a UUID, i.e.:
>>>
>>> <auth username='myuser'>
>>> <secret type='ceph' usage='secretname'/>
>>> </auth>
>>>
>>> or
>>>
>>> <auth username='myuser'>
>>> <secret type='ceph' uuid='0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f'/>
>>> </auth>
>>>
>
>>> +++ b/src/Makefile.am
>>> @@ -128,7 +128,8 @@ DOMAIN_CONF_SOURCES = \
>>> conf/capabilities.c conf/capabilities.h \
>>> conf/domain_conf.c conf/domain_conf.h \
>>> conf/domain_audit.c conf/domain_audit.h \
>>> - conf/domain_nwfilter.c conf/domain_nwfilter.h
>>> + conf/domain_nwfilter.c conf/domain_nwfilter.h \
>>> + conf/secret_conf.c
>>
>>
>> Unless I'm missing something, I don't think your code changes to
>> domain_conf.c actually introduce any dependancy on secret_conf.c
>> You include secret_conf.h, but that is only to get access to one
>> of the enum values. So there's no dep on the secret_conf.c code
>> and you can just drop this hunk
>
> Actually, the linker now wants to pull in
> virSecretUsageTypeTypeFromString (yuck; why do we have that doubled
> "Type" in the name?), so that means more drivers have to add a link
> library, to prevent problems like this:
>
> libvirt_lxc-domain_conf.o: In function `virDomainDiskDefParseXML':
> /home/remote/eblake/libvirt/src/conf/domain_conf.c:2479: undefined
> reference to `virSecretUsageTypeTypeFromString'
>
>>> + </attribute>
>>> + <attribute name="usage">
>>> + <ref name="genericName"/>
>
> This says usage='name' uses a genericName, but in secret.rng, you said
> element <name> could use arbitrary text - that is, we have a discrepancy
> where the secret could have an arbitrary name which validates for
> secret.rng but fails to validate for <auth> as part of domain.rng. You
> probably ought to do a followup patch that consolidates the two .rng
> files to use the same definition for what you will accept as a valid
> Ceph secret name.

Yeah, I'll fix that.

>>>
>>> + if (def->auth.username) {
>>> + virBufferAsprintf(buf, "<auth username='%s'>\n",
>>> + def->auth.username);
>>> + if (def->auth.secretType == VIR_DOMAIN_DISK_SECRET_TYPE_UUID) {
>>> + virUUIDFormat(def->auth.secret.uuid, uuidstr);
>>> + virBufferAsprintf(buf,
>>> + "<secret type='passphrase' uuid='%s'/>\n",
>
> This disagrees with your type='ceph' in the commit message (twice). You
> would have caught this had you added a test that does round-trip from
> XML in and back out somewhere in the series. Could you please do that as
> a followup patch?

Oops, sorry about that. The reason I didn't include a test going from 
commandline to secret is that we're going to be passing the secret 
through the qemu monitor so it won't be exposed on the command line.

>>> + uuidstr);
>>> + }
>>> + if (def->auth.secretType == VIR_DOMAIN_DISK_SECRET_TYPE_USAGE) {
>>> + virBufferAsprintf(buf,
>
> This must use virBufferEscapeString, since the user's "usage" string may
> have arbitrary text.
>
>>> + "<secret type='passphrase' usage='%s'/>\n",
>>> + def->auth.secret.usage);
>>> + }
>>> + virBufferAsprintf(buf, "</auth>\n");
>
> AddLit is more efficient than Asprintf for a constant string.
>
>>> +enum virDomainDiskSecretType {
>>> + VIR_DOMAIN_DISK_SECRET_TYPE_NONE,
>>> + VIR_DOMAIN_DISK_SECRET_TYPE_UUID,
>>> + VIR_DOMAIN_DISK_SECRET_TYPE_USAGE,
>>> +
>>> + VIR_DOMAIN_DISK_SECRET_TYPE_LAST
>>> +};
>>> +
>>> /* Stores the virtual disk configuration */
>>> typedef struct _virDomainDiskDef virDomainDiskDef;
>>> typedef virDomainDiskDef *virDomainDiskDefPtr;
>>> @@ -281,6 +289,14 @@ struct _virDomainDiskDef {
>>> int protocol;
>>> int nhosts;
>>> virDomainDiskHostDefPtr hosts;
>>> + struct {
>>> + char *username;
>>> + int secretType;
>
> I like to add a comment stating which values are expected in this field
> (here, enum virDomainDiskSecretType).
>
>>
>> ACK with the Makefile.am hunk dropped
>
> Also missing documentation. Here's what I had to squash in for that,
> before pushing. Also, I added Josh to AUTHORS (shoot, I also realized
> that I botched Josh's email in 1/4 when hand-applying everything, due to
> battling the lost emails, sorry about that).
>
> diff --git i/docs/formatdomain.html.in w/docs/formatdomain.html.in
> index fcffb25..f31b775 100644
> --- i/docs/formatdomain.html.in
> +++ w/docs/formatdomain.html.in
> @@ -913,6 +913,16 @@
> &lt;transient/&gt;
> &lt;address type='drive' controller='0' bus='1' unit='0'/&gt;
> &lt;/disk&gt;
> + &lt;disk type='network'&gt;
> + &lt;driver name="qemu" type="raw"/&gt;
> + &lt;source protocol="rbd" name="image_name2"&gt;
> + &lt;host name="hostname" port="7000"/&gt;
> + &lt;/source&gt;
> + &lt;target dev="hdd" bus="ide"/&gt;
> + &lt;auth username='myuser'&gt;
> + &lt;secret type='ceph' usage='mypassid'/&gt;
> + &lt;/auth&gt;
> + &lt;/disk&gt;
> &lt;disk type='block' device='cdrom'&gt;
> &lt;driver name='qemu' type='raw'/&gt;
> &lt;target def='hdc' bus='ide'/&gt;
> @@ -1160,7 +1170,24 @@
> "drive" controller, additional attributes
> <code>controller</code>, <code>bus</code>,
> and <code>unit</code> are available, each defaulting to 0.
> -
> + </dd>
> + <dt><code>auth</code></dt>
> + <dd>If present, the <code>auth</code> element provides the
> + authentication credentials needed to access the source. It
> + includes a mandatory attribute <code>username</code>, which
> + identifies the username to use during authentication, as well
> + as a sub-element <code>secret</code> with mandatory
> + attribute <code>type</code>, to tie back to
> + a <a href="formatsecret.html">libvirt secret object</a> that
> + holds the actual password or other credentials (the domain XML
> + intentionally does not expose the password, only the reference
> + to the object that does manage the password). For now, the
> + only known secret <code>type</code> is "ceph", for Ceph RBD
> + network sources, and requires either an
> + attribute <code>uuid</code> with the UUID of the Ceph secret
> + object, or an attribute <code>usage</code> with the name
> + associated with the Ceph secret
> + object. <span class="since">libvirt 0.9.7</span>
> </dd>
> </dl>
>
> diff --git i/src/Makefile.am w/src/Makefile.am
> index 5b3a66f..995afae 100644
> --- i/src/Makefile.am
> +++ w/src/Makefile.am
> @@ -128,8 +128,7 @@ DOMAIN_CONF_SOURCES = \
> conf/capabilities.c conf/capabilities.h \
> conf/domain_conf.c conf/domain_conf.h \
> conf/domain_audit.c conf/domain_audit.h \
> - conf/domain_nwfilter.c conf/domain_nwfilter.h \
> - conf/secret_conf.c conf/secret_conf.h
> + conf/domain_nwfilter.c conf/domain_nwfilter.h
>
> DOMAIN_EVENT_SOURCES = \
> conf/domain_event.c conf/domain_event.h
> @@ -1476,6 +1475,7 @@ libvirt_lxc_SOURCES = \
> $(NODE_INFO_SOURCES) \
> $(ENCRYPTION_CONF_SOURCES) \
> $(DOMAIN_CONF_SOURCES) \
> + $(SECRET_CONF_SOURCES) \
> $(CPU_CONF_SOURCES) \
> $(NWFILTER_PARAM_CONF_SOURCES)
> libvirt_lxc_LDFLAGS = $(WARN_CFLAGS) $(AM_LDFLAGS)
>
> diff --git i/src/libvirt_private.syms w/src/libvirt_private.syms
> index 987c512..288911a 100644
> --- i/src/libvirt_private.syms
> +++ w/src/libvirt_private.syms
> @@ -930,6 +930,8 @@ virSecretDefFormat;
> virSecretDefFree;
> virSecretDefParseFile;
> virSecretDefParseString;
> +virSecretUsageTypeTypeFromString;
> +virSecretUsageTypeTypeToString;
>
>
> # security_driver.h
>

