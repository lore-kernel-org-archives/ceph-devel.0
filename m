From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: stuff for v0.56.4
Date: Thu, 7 Mar 2013 10:08:19 -0500
Message-ID: <CACkq2mo+SxVOFV6VDqLjY0QVubZD0W7b325CH2pvyNXsAjOoBg@mail.gmail.com>
References: <alpine.DEB.2.00.1303051503480.1162@cobra.newdream.net> <51370059.4050403@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:36006 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab3CGPIm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 10:08:42 -0500
Received: by mail-bk0-f44.google.com with SMTP id j4so270039bkw.31
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 07:08:40 -0800 (PST)
In-Reply-To: <51370059.4050403@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

As long as the fix for...

osdc/ObjectCacher.cc: In function 'void
ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
tid_t, int)' thread 7fd316a50700 time 2013-03-07 15:03:21.641190
osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)

...s in there (which you already put on the bobtail branch, I believe)
I will be happy.  This particular bug crashes several VMs a day for
me.

 - Travis

On Wed, Mar 6, 2013 at 3:37 AM, Wido den Hollander <wido@42on.com> wrote:
> On 03/06/2013 12:10 AM, Sage Weil wrote:
>>
>> There have been a few important bug fixes that people are hitting or
>> want:
>>
>> - the journal replay bug (5d54ab154ca790688a6a1a2ad5f869c17a23980a)
>> - the - _ pool name vs cap parsing thing that is biting openstack users
>> - ceph-disk-* changes to support latest ceph-deploy
>>
>> If there are other things that we want to include in 0.56.4, lets get them
>> into the bobtial branch sooner rather than later.
>>
>> Possible items:
>>
>> - pg log trimming (probably a conservative subset) to avoid memory bloat
>> - omap scrub?
>> - pg temp collection removal?
>> - buffer::cmp fix from loic?
>>
>> Are there other items that we are missing?
>>
>
> I'm still seeing #3816 on my systems. The fix in wip-3816 did not resolve it
> for me.
>
> Wido
>
>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
