From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Ceph copy-on-write
Date: Fri, 4 Nov 2011 12:54:42 -0700
Message-ID: <CAORUGqA-mc399rQPwx0DyEMikMRszWGJijpgBw-7dPeMJEi0gw@mail.gmail.com>
References: <4EB35754.1040506@gmail.com> <CAORUGqAUW4Z-+KmfBwxXTpdsF+T52HrPuQuQzcSuA9Z=UA7DyQ@mail.gmail.com>
 <4EB43E4A.5050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab1KDTzG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 15:55:06 -0400
Received: by wwi36 with SMTP id 36so4006292wwi.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 12:55:04 -0700 (PDT)
In-Reply-To: <4EB43E4A.5050001@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maxim Mikheev <mikhmv@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Nov 4, 2011 at 12:34, Maxim Mikheev <mikhmv@gmail.com> wrote:
> I have another question. Looks like repository version 0.37 for ubuntu
> oneric has brocken dependencies
> for ceph-client-tools.
> Can you advice how can I install it?

v0.37 renamed ceph-client-tools to ceph-common. Unfortunately, we
didn't test the upgrade path, and the new ceph-common package doesn't
replace ceph-client-tools automatically (this was fixed in
ee34e09c6129297b3c4e9405138a4e3807d47118). You can remove
ceph-client-tools manually, to get the upgrade to complete.
