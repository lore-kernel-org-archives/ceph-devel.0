From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Seperate metadata disk for OSD
Date: Sat, 12 Jan 2013 07:36:12 -0600
Message-ID: <50F166CC.40009@inktank.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC5D36A6@SHSMSX102.ccr.corp.intel.com> <CAAM7YA=h2tWx_NyiDm32jNxq=oQXQfAD5HN0tc0vQz1-srp-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:35796 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab3ALNna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Jan 2013 08:43:30 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so2346973iad.41
        for <ceph-devel@vger.kernel.org>; Sat, 12 Jan 2013 05:43:30 -0800 (PST)
In-Reply-To: <CAAM7YA=h2tWx_NyiDm32jNxq=oQXQfAD5HN0tc0vQz1-srp-aA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng " <yanzheng@21cn.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Xiaoxi and Zheng,

We've played with both of these some internally, but not for a 
production deployment. Mostly just for diagnosing performance problems. 
  It's been a while since I last played with this, but I hadn't seen a 
whole lot of performance improvements at the time.  That may have been 
due to the hardware in use, or perhaps other parts of Ceph have improved 
to the point where this matters now!

On a side note, Btrfs also had a google summer of code project to let 
you put metadata on an external device.  Originally I think that was 
supposed to make it into 3.7, but am not sure if that happened.

Mark

On 01/12/2013 06:21 AM, Yan, Zheng wrote:
> On Sat, Jan 12, 2013 at 2:57 PM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
>>
>> Hi list,
>>          For a rbd write request, Ceph need to do 3 writes:
>> 2013-01-10 13:10:15.539967 7f52f516c700 10 filestore(/data/osd.21) _do_transaction on 0x327d790
>> 2013-01-10 13:10:15.539979 7f52f516c700 15 filestore(/data/osd.21) write meta/516b801c/pglog_2.1a/0//-1 36015~147
>> 2013-01-10 13:10:15.540016 7f52f516c700 15 filestore(/data/osd.21) path: /data/osd.21/current/meta/DIR_C/pglog\u2.1a__0_516B801C__none
>> 2013-01-10 13:10:15.540164 7f52f516c700 15 filestore(/data/osd.21) write meta/28d2f4a8/pginfo_2.1a/0//-1 0~496
>> 2013-01-10 13:10:15.540189 7f52f516c700 15 filestore(/data/osd.21) path: /data/osd.21/current/meta/DIR_8/pginfo\u2.1a__0_28D2F4A8__none
>> 2013-01-10 13:10:15.540217 7f52f516c700 10 filestore(/data/osd.21) _do_transaction on 0x327d708
>> 2013-01-10 13:10:15.540222 7f52f516c700 15 filestore(/data/osd.21) write 2.1a_head/8abf341a/rb.0.106e.6b8b4567.0000000002d3/head//2 3227648~524288
>> 2013-01-10 13:10:15.540245 7f52f516c700 15 filestore(/data/osd.21) path: /data/osd.21/current/2.1a_head/rb.0.106e.6b8b4567.0000000002d3__head_8ABF341A__2
>>l
>>          If using XFS as backend file system and running xfs on top of traditional sata disk, it will introduce a lot of seeks and therefore reduce bandwidth, a blktrace is available here :( http://ww3.sinaimg.cn/mw690/6e1aee47jw1e0qsbxbvddj.jpg) to demonstrate this issue.( single client running dd on top of a new RBD volumes).
>>          Then I tried to move /osd.X/current/meta to a separate disk, the bandwidth boosted.(look blktrace at http://ww4.sinaimg.cn/mw690/6e1aee47jw1e0qsadz1bij.jpg).
>>          I haven't test other access pattern or something else, but it looks to me that moving such meta to a separate disk (ssd or sata with btrfs) will benefit ceph write performance, is it true? Will ceph introduce this feature in the future?  Is there any potential problem for such hack?
>>
>
> Did you try putting XFS metadata log a separate and fast device
> (mkfs.xfs -l logdev=/dev/sdbx,size=10000b). I think it will boost
> performance too.
>
> Regards
> Yan, Zheng
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

