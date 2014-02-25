From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 0/6] libceph: CEPH_OSD_OP_SETALLOCHINT osd op
Date: Tue, 25 Feb 2014 14:50:10 +0200
Message-ID: <CALFYKtD=gdfv6htmHMByPn=CsLrssXSJnP=5oD0ECUNUk9GjSA@mail.gmail.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
	<530B5E2E.3010905@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:54229 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbaBYM4V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 07:56:21 -0500
Received: by mail-qa0-f46.google.com with SMTP id k15so298776qaq.5
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 04:56:21 -0800 (PST)
In-Reply-To: <530B5E2E.3010905@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 24, 2014 at 4:58 PM, Alex Elder <elder@ieee.org> wrote:
> On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
>> Hello,
>>
>> This series adds support for CEPH_OSD_OP_SETALLOCHINT osd op to libceph
>> along with adjusting rbd to make use of it.  The rationale and the
>> basic desing was outlined in the "rados io hints" thread on ceph-devel
>> about a month ago.
>
> It looks like some of this discussion is still active, so it
> might be a little premature to implement this.  That being said,
> I reviewed what you have.  Overall it looks good to me.  I have
> some small suggestions for you to consider.  I also think that
> in this case just extending the definition of a write request
> is preferable to encoding this stuff in a distinct new op, but
> I may be missing some information.

Hi Alex,

Thanks for the review!  I've incorporated most of your suggestions, see
my replies for details.  I'll post v2 series shortly, feel free to send
your Reviewed-by for 6/6 any time ;)

Thanks,

                Ilya
