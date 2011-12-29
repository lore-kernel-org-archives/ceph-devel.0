From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: Hang at 'rbd info <image>'
Date: Thu, 29 Dec 2011 09:41:07 -0800
Message-ID: <CAC-hyiH0301MUSvhe5sG_NTWggPJXrZdWQbpRuQ31Ctd0HE2Bw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49DA2EE99@WHQBEMAIL1.whq.wistron>
	<CAORUGqADEE=kGB2jbMs_M__jnLjHU39ONg6eAOro+H40YGYECw@mail.gmail.com>
	<8512670932FB654F81AF0FEF1BE6D49DB0E5B5@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64611 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1L2RlH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 12:41:07 -0500
Received: by yenm11 with SMTP id m11so7505285yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Dec 2011 09:41:07 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49DB0E5B5@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: tommi.virtanen@dreamhost.com, ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On Thu, Dec 29, 2011 at 1:49 AM,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, Tommi:
>
> =A0 The health of ceph is 'HEALTH_OK'.
>
> =A0 Do you want to see any other information of ceph cluster?
>
> =A0 =A0I also tried these two command but no use.
>
> =A0 `ceph osd repair *`
> =A0 `ceph osd scrub *`
>
> =A0 =A0And I also cannot map the rbd image to rbd device.
>
> =A0 =A0Is there any solution to fix it? I cannot access the rbd image=
 anymore.
>

What does 'ceph -s' say?

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
