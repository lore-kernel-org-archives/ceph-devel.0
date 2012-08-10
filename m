From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more flexible
Date: Fri, 10 Aug 2012 09:57:02 -0700
Message-ID: <CA+jddaMq2G5Y8b81T7XKDL6=sbFTB8TWd_hy2wcQ=N=mpAMH5g@mail.gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
	<alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net>
	<502530C9.7030008@bisect.de>
	<alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36734 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab2HJQ5E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 12:57:04 -0400
Received: by vbbff1 with SMTP id ff1so1341445vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Aug 2012 09:57:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Comment below in-line:

On Fri, Aug 10, 2012 at 9:12 AM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 10 Aug 2012, Danny Kukawka wrote:
>> Am 10.08.2012 17:54, schrieb Sage Weil:
>> > On Thu, 9 Aug 2012, Danny Kukawka wrote:
>> >> Remove btrfs specific keys and replace them by more generic
>> >> keys to be able to replace btrfs with e.g. xfs or ext4 easily.
>> >>
>> >> Add new key to define the osd fs type: 'fstype', which can get
>> >> defined in the [osd] section for all OSDs.
>> >>
>> >> Replace:
>> >> - 'btrfs devs' -> 'devs'
>> >> - 'btrfs path' -> 'fs path'
>> >> - 'btrfs options' -> 'fs options'
>> >> - mkcephfs: replace --mkbtrfs with --mkfs

I'm just a little concerned about this as --mkfs in other parts of the
project refers to the on file system changes to prepare the directory
structure for use by the daemons.  I actually prefer the usage here, I
only want to point out the confusing CLI parameter collision.

>> >> - init-ceph: replace --btrfs with --fsmount, --nobtrfs
>> >> with --nofsmount, --btrfsumount with --fsumount
>> >>
>> >> Update documentation, manpage and example config files.
>> >
>> > Maybe this should keep the old options as well, so that --mkbtrfs is an
>> > alias for --mkfs --btrfs...
>>
>> I can add this to the patch, no problem!
>>
>> > Tommi, is this kind of invocation compatible with your notion of what
>> > mkcephfs 2.0 should be?  If we can jump to the target interface and
>> > rewrite the implementation in terms of the new tools that would capture
>> > the best of both worlds.
>>
>> If you can point me to some documentation how the target interface
>> works, I could take a look at adapting mkcephfs to the new tools as soon
>> as the new interface/workflow is ready.
>
> It's not defined yet.  I know Tommi has something in his head, but I'm not
> sure if it's something similar to the current one (a cluster-wide
> ceph.conf) or something else.  He's off today, so we probably have to wait
> to find out.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
