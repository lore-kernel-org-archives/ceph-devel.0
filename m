From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Code Documentation Conventions
Date: Mon, 19 Dec 2011 10:08:14 -0800
Message-ID: <CAORUGqCmaOk8_XsDvRzGZrZ_EZ97J3=uBEM38aKOys3ggSn2GA@mail.gmail.com>
References: <4EEBAF78.8010605@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43265 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1LSSIg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2011 13:08:36 -0500
Received: by faar15 with SMTP id r15so3362564faa.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2011 10:08:35 -0800 (PST)
In-Reply-To: <4EEBAF78.8010605@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Dec 16, 2011 at 12:52, Josh Durgin <josh.durgin@dreamhost.com> =
wrote:
> I've been documenting the librados C api, and would like to get some
> feedback on the format being used. For each function, the format is
> generally:
>
> /**
> =C2=A0* Short description
> =C2=A0*

Personally I've never been crazy about the "*" prefix on every line,
it looks just like extra work without value to me. Doxygen itself is
perfectly happy with just

/**
  Short description

  blah
  blah
 */

But whatever makes sense for you guys.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
