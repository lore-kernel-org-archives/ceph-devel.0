From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH v5 4/4] qemu/rbd: improve rbd device specification
Date: Tue, 15 Nov 2011 17:37:28 -0800
Message-ID: <4EC313D8.6040507@dreamhost.com>
References: <4EAEFED2.70808@redhat.com> <3bd8191e8040b4ebe95d31200373539be7ba6e95.1320110364.git.josh.durgin@dreamhost.com> <4EC2FE47.60501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48502 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822Ab1KPBh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 20:37:29 -0500
In-Reply-To: <4EC2FE47.60501@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 11/15/2011 04:05 PM, Eric Blake wrote:
> On 10/31/2011 07:29 PM, Josh Durgin wrote:
>> From: Sage Weil<sage@newdream.net>
>
> Sorry for letting my review of this slip 2 weeks.
>
>>
>> This improves the support for qemu rbd devices by adding support for a few
>> key features (e.g., authentication) and cleaning up the way in which
>> rbd configuration options are passed to qemu.
>>
>> An<auth>  member of the disk source xml specifies how librbd should
>> authenticate. The username attribute is the Ceph/RBD user to authenticate as.
>> The usage or uuid attributes specify which secret to use. Usage is an
>> arbitrary identifier local to libvirt.
>>
>> The old RBD support relied on setting an environment variable to
>> communicate information to qemu/librbd.  Instead, pass those options
>> explicitly to qemu.  Update the qemu argument parsing and tests
>> accordingly.
>>
>> Signed-off-by: Sage Weil<sage@newdream.net>
>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
>> ---
>>
>> Changes since v4:
>> * fixes memory management issues
>> * keep older rbd command line parsing and test case
>> * check qemuAddRBDHost return values
>> * use more efficient virBuffer functions
>
> Looks like you got all my review points.
>
> ACK and pushed, although I do have some questions that may deserve
> followup patches:
>
>> +static int
>> +qemuBuildRBDString(virConnectPtr conn,
>> +                   virDomainDiskDefPtr disk,
>> +                   virBufferPtr opt)
>> +{
>> +    int i, ret = 0;
>> +    virSecretPtr sec = NULL;
>> +    char *secret = NULL;
>> +    size_t secret_size;
>> +
>> +    virBufferAsprintf(opt, "rbd:%s", disk->src);
>> +    if (disk->auth.username) {
>> +        virBufferEscape(opt, ":", ":id=%s", disk->auth.username);
>
> This results in ambiguous output if disk->auth.username can end in a
> single backslash (since then, you would have \: when combined with the
> next part of the option, making it look like the next ":mon_host="
> option is instead a continuation of the ":id=" username).  Should we be
> escaping backslash as well as colon?  Or should virBufferEscape be
> taught to always escape backslash in addition to whatever characters
> were passed in to its 'toescape' argument?

Escaping backslashes wouldn't hurt, but these usernames aren't expected 
to have backslashes in them (they're genericNames in the xml schema).

>
>> +        if (sec) {
>> +            char *base64 = NULL;
>> +
>> +            secret = (char *)conn->secretDriver->getValue(sec,&secret_size, 0,
>> +                                                          VIR_SECRET_GET_VALUE_INTERNAL_CALL);
>> +            if (secret == NULL) {
>> +                qemuReportError(VIR_ERR_INTERNAL_ERROR,
>> +                                _("could not get the value of the secret for username %s"),
>> +                                disk->auth.username);
>> +                goto error;
>> +            }
>> +            /* qemu/librbd wants it base64 encoded */
>> +            base64_encode_alloc(secret, secret_size,&base64);
>> +            if (!base64) {
>> +                virReportOOMError();
>> +                goto error;
>> +            }
>> +            virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx none",
>> +                            base64);
>> +            VIR_FREE(base64);
>
> The command line that we pass to qemu gets logged.  But what happens if
> the secret was marked as ephemeral - could we be violating the premise
> of not exposing passwords to too broad an audience?  Or are we already
> safe in that the log entries created by virCommand can only be exposed
> to users that already can get at the secret information by other means?

The secret can be read from the command line of the running process, 
which is even less secure than the log. I'm working on passing the 
secret via the qemu monitor instead of the command line, which will 
avoid both issues.

> Maybe this means we should we be adding capabilities into virCommand to
> prevent the logging of the actual secret (whether base64-encoded or
> otherwise), and instead log an alternate string?  That is, should
> virCommand be tracking parallel argv arrays; the real array passed to
> exec() but never logged, and the alternate array (normally matching the
> real one, but which can differ in this particular case of passing an
> argument that contains a password)?
>

