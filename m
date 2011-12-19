From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Code Documentation Conventions
Date: Mon, 19 Dec 2011 10:13:30 -0800
Message-ID: <CAF3hT9DOwHdPAgEzMu-mkrbrWiMQagPHcQ_gUcuP7ETwAMVDWA@mail.gmail.com>
References: <4EEBAF78.8010605@dreamhost.com>
	<CAORUGqCmaOk8_XsDvRzGZrZ_EZ97J3=uBEM38aKOys3ggSn2GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46751 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab1LSSNa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 13:13:30 -0500
Received: by iaeh11 with SMTP id h11so8888950iae.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 10:13:30 -0800 (PST)
In-Reply-To: <CAORUGqCmaOk8_XsDvRzGZrZ_EZ97J3=uBEM38aKOys3ggSn2GA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, ceph-devel@vger.kernel.org

On Mon, Dec 19, 2011 at 10:08 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Dec 16, 2011 at 12:52, Josh Durgin <josh.durgin@dreamhost.com=
> wrote:
>> I've been documenting the librados C api, and would like to get some
>> feedback on the format being used. For each function, the format is
>> generally:
>>
>> /**
>> =A0* Short description
>> =A0*
>
> Personally I've never been crazy about the "*" prefix on every line,
> it looks just like extra work without value to me. Doxygen itself is
> perfectly happy with just
>
> /**
> =A0Short description
>
> =A0blah
> =A0blah
> =A0*/
>
> But whatever makes sense for you guys.
I like it as a visibility and "comment type" thing. Plus any good
editor will auto-type those for you... ;)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
