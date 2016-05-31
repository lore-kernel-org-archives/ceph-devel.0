From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Little update on the build platform
Date: Tue, 31 May 2016 20:16:12 +0200
Message-ID: <20160531181612.GE20357@predictor>
References: <1236727659.97766119.1464716235552.JavaMail.zimbra@redhat.com>
 <902296593.97770947.1464716952266.JavaMail.zimbra@redhat.com>
 <20160531175856.GD20357@predictor>
 <1322819826.97774670.1464717769627.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:56995 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438AbcEaSNu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 14:13:50 -0400
Content-Disposition: inline
In-Reply-To: <1322819826.97774670.1464717769627.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 31, 2016 at 02:02:49PM -0400, Erwan Velu wrote:
> That's pretty easy for a human to determine if a PR does affect the c=
ode.
> If we'd like to automate that, that would mean having a list of files=
 known not to need triggering a rebuild and updating that list everytim=
e a new file is added/retired.

How about ignoring everything that is under /doc/ and not under /doc/ma=
n/?
Seems like it would do the trick most of the time...

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
