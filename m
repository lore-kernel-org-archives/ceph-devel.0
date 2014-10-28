From: Samuel Just <sam.just@inktank.com>
Subject: Re: Regarding hammer blueprints
Date: Tue, 28 Oct 2014 12:39:48 -0700
Message-ID: <CA+4uBUbJC2B5J8NOmW8rQXhp5ysC5E2eFpWrYB9L4WQ1dP0k_w@mail.gmail.com>
References: <37A1BCB5EFF35248B6849AC7BCB09FC809D28763@SACMBXIP02.sdcorp.global.sandisk.com>
	<CA+4uBUYWwttjcrTdu6tZ+uibwdo0Dnm8YS-8QKspgWt+iPi=Yg@mail.gmail.com>
	<37A1BCB5EFF35248B6849AC7BCB09FC809D30E60@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:44349 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbaJ1Tjt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 15:39:49 -0400
Received: by mail-la0-f42.google.com with SMTP id gq15so1317274lab.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Oct 2014 12:39:48 -0700 (PDT)
In-Reply-To: <37A1BCB5EFF35248B6849AC7BCB09FC809D30E60@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anand Bhat <Anand.Bhat@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think I will get to it in the next few weeks.  I know how I want it
to look, and I actually started a branch before the great deluge of
giant freeze bugs.
-Sam

On Mon, Oct 27, 2014 at 9:52 PM, Anand Bhat <Anand.Bhat@sandisk.com> wrote:
> Sam,
>
> Are you actively working on this? If not, can I start working on this?
>
> Regards,
> Anand
>
> -----Original Message-----
> From: Samuel Just [mailto:sam.just@inktank.com]
> Sent: Tuesday, October 21, 2014 11:58 PM
> To: Anand Bhat
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Regarding hammer blueprints
>
> The priority queue changes are, in fact, that blueprint.
> -Sam
>
> On Tue, Oct 21, 2014 at 5:14 AM, Anand Bhat <Anand.Bhat@sandisk.com> wrote:
>> Sage/Sam,
>>
>> There was a mention of "unified priority queue" hammer blueprint in one of the mail chains. I don't see anything related to that in the Hammer blueprint list (https://wiki.ceph.com/Planning/Blueprints/Hammer). Is it still planned for Hammer release?
>>
>> There is a blueprint named  "osd: Scrub/SnapTrim IO prioritization" in the Hammer blueprint list. Are the priority queue changes handled as part of this blueprint?
>>
>> Regards,
>> Anand
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
