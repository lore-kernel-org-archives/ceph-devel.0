From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Behavior of librbd::Image::read_iterate() changed?
Date: Sat, 8 Dec 2012 11:44:30 +0800
Message-ID: <CANExM-MYm5iomxv1GszEOo4+PJouGCzC+ssjm0FHhX1GuD-FXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:60305 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917Ab2LHDwp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 22:52:45 -0500
Received: by mail-ia0-f172.google.com with SMTP id z13so1937544iaz.3
        for <ceph-devel@vger.kernel.org>; Fri, 07 Dec 2012 19:52:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I am testing v0.55. I noticed that the behavior of
librbd::Image::read_iterate() changed. With 0.48.2, when hitting the
hole, the callback function will be called with the buf set to NULL.
However, with v0.55, I got the zero-ed buffer of full length of the
object (e.g., 4MB).

Is it the expected behavior or a bug?

Henry
