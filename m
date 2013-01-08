From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: v0.56.1 released
Date: Tue, 8 Jan 2013 10:40:23 +0300
Message-ID: <CABYiri_ECmQGPJDvZoGUybFKuc7HYgk4PJ193U+oTebNMD=O7Q@mail.gmail.com>
References: <alpine.DEB.2.00.1301072052180.20676@cobra.newdream.net> <50EBCB21.9090207@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:33754 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3AHHko (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 02:40:44 -0500
Received: by mail-oa0-f53.google.com with SMTP id j6so81216oag.40
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 23:40:43 -0800 (PST)
In-Reply-To: <50EBCB21.9090207@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Jan 8, 2013 at 11:30 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi,
>
> i cannot see any git tag or branch claming to be 0.56.1? Which commit id is
> this?
>
> Greets
>   Stefan

Same for me, github simply does not sent a new tag in the pull to
local tree by some reason. Repository cloning from scratch resolved
this :)

>
>
> Am 08.01.2013 05:53, schrieb Sage Weil:
>
>> We found a few critical problems with v0.56, and fixed a few outstanding
>> problems. v0.56.1 is ready, and we're pretty pleased with it!
>>
>> There are two critical fixes in this update: a fix for possible data loss
>> or corruption if power is lost, and a protocol compatibility problem that
>> was introduced in v0.56 (between v0.56 and any other version of ceph).
>>
>>   * osd: fix commit sequence for XFS, ext4 (or any other non-btrfs) to
>>     prevent data loss on power cycle or kernel panic
>>   * osd: fix compatibility for CALL operation
>>   * osd: process old osdmaps prior to joining cluster (fixes slow startup)
>>   * osd: fix a couple of recovery-related crashes
>>   * osd: fix large io requests when journal is in (non-default) aio mode
>>   * log: fix possible deadlock in logging code
>>
>> This release will kick off the bobtail backport series, and will get a
>> shiny new URL for it's home.
>>
>>   * Git at git://github.com/ceph/ceph.git
>>   * Tarball at http://ceph.com/download/ceph-0.56.1.tar.gz
>>   * For Debian/Ubuntu packages, see
>> http://ceph.com/docs/master/install/debian
>>   * For RPMs, see http://ceph.com/docs/master/install/rpm
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
