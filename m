From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/5] libceph: separate non-locked fault handling
Date: Fri, 22 Feb 2013 11:32:18 -0600
Message-ID: <5127ABA2.1020109@inktank.com>
References: <5127A85D.1070000@inktank.com> <5127A935.8020605@inktank.com> <5127AA2C.7090709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41614 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977Ab3BVRcV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:32:21 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so994372iea.38
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:32:21 -0800 (PST)
In-Reply-To: <5127AA2C.7090709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

On 02/22/2013 11:26 AM, Alex Elder wrote:
> An error occurring on a ceph connection is treated as a fault,
> causing the connection to be reset.  The initial part of this fault
> handling has to be done while holding the connection mutex, but
> it must then be dropped for the last part.
. . .

Sorry about the duplicate(s) and the messed up subject
lines.  I got a little trouble from gmail in the middle
of posting these.

					-Alex


