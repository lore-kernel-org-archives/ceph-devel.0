From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: ceph admin command: debuggging
Date: Mon, 12 Aug 2013 07:21:28 +0200
Message-ID: <20130812072128.7a0bab97@andylap>
References: <20130808160417.3589315c@doppio>
	<alpine.DEB.2.00.1308081508360.986@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from port-212-202-108-184.static.qsc.de ([212.202.108.184]:2526 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755070Ab3HLFVe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Aug 2013 01:21:34 -0400
In-Reply-To: <alpine.DEB.2.00.1308081508360.986@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

On Thu, 8 Aug 2013 15:09:27 -0700 (PDT)
Sage Weil <sage@inktank.com> wrote:

> On Thu, 8 Aug 2013, Andreas Bluemle wrote:
> > Hi,
> > 
> > maybe this is the wrong list - but I am looking for
> > logging support for the /usr/bin/ceph adminstration
> > comamand.
> > 
> > This is build from the same source as the ceph daemons are.
> > 
> > For the daemons, logging is controlled for the different
> > comoponents of a daemon on behalf of configuration file
> > directives (e.g. "debug ms" for the message I/O).
> > 
> > Can this be applied to the /usr/bin/ceph command, too?
> > And where would the log file go?
> 
> You are probably looking for:
> 
>  --log-to-stderr     (make log output go to stderr)
>  --log-file <filename>
> 
> and you can make some noise with
> 
>  --debug-ms 1
>  --debug-monc 10
> 
> (for example)
>

Thanks; I'll give that a try.

Andreas Bluemle


> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
Heinrich Boell Strasse 88           Phone: (+49) 89 4317582
D-81829 Muenchen (Germany)          Mobil: (+49) 177 522 0151
