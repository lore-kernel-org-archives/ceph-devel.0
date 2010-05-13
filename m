From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: additional librados functions
Date: Thu, 13 May 2010 09:12:14 -0700
Message-ID: <AANLkTikM8Tm5lACs6BStW8j7y9a2NeMbAUdI1lEdlyYM@mail.gmail.com>
References: <20100513153453.GC53373@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:37204 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759266Ab0EMQMO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 May 2010 12:12:14 -0400
Received: by pzk42 with SMTP id 42so805297pzk.4
        for <ceph-devel@vger.kernel.org>; Thu, 13 May 2010 09:12:14 -0700 (PDT)
In-Reply-To: <20100513153453.GC53373@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Thu, May 13, 2010 at 8:34 AM, Christian Brunner <chb@muc.de> wrote:
> 1. I would like to be able to clone an image. This doesn't need to be
> =A0 based on a snapshot. Doing a simple copy of the objects would be
> =A0 sufficient. I could do this by using rados_read and rados_write e=
asily.
> =A0 However I think that calling something like rados_copy would be m=
ore
> =A0 efficient, since the client wouldn't be involved. =A0Would it be =
possible
> =A0 to provide such a call?
This is something we keep thinking about but discarding as not
important enough yet.
Probably any implementation we do come up with would involve the
client telling each OSD with a chunk to copy their chunk to another
specific OSD.
One issue that comes to mind with any rados-based copy is that it
won't be atomic since it has to involve a sequence of instructions.
Making the client read and write makes sure they know they're
responsible for consistency across the copy without freezing up access
to every object being copied for the entire duration.

> 2. For accounting purposes I would like to read pool statistics. In t=
he
> =A0 librados header file I can see that there are two structures () w=
here
> =A0 the data may get stored. However I can't find a function to fill =
these
> =A0 structures. Am I missing something here?
=46or this one, it looks like we simply never developed the C interface
for those functions -- they exist in the C++ header and
implementation!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
