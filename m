From: Sage Weil <sage@newdream.net>
Subject: Re: additional librados functions
Date: Thu, 13 May 2010 10:53:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005131053120.13692@cobra.newdream.net>
References: <20100513153453.GC53373@ncolin.muc.de>
 <AANLkTikM8Tm5lACs6BStW8j7y9a2NeMbAUdI1lEdlyYM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1206650736-1273773237=:13692"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48108 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab0EMRut (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 May 2010 13:50:49 -0400
In-Reply-To: <AANLkTikM8Tm5lACs6BStW8j7y9a2NeMbAUdI1lEdlyYM@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1206650736-1273773237=:13692
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 May 2010, Gregory Farnum wrote:
> On Thu, May 13, 2010 at 8:34 AM, Christian Brunner <chb@muc.de> wrote:
> > 2. For accounting purposes I would like to read pool statistics. In the
> > =A0 librados header file I can see that there are two structures () whe=
re
> > =A0 the data may get stored. However I can't find a function to fill th=
ese
> > =A0 structures. Am I missing something here?
> For this one, it looks like we simply never developed the C interface
> for those functions -- they exist in the C++ header and
> implementation!

I added this to the C API and pushed to the unstable branch.

sage
--557981400-1206650736-1273773237=:13692--
