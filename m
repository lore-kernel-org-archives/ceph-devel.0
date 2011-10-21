From: Christian Brunner <chb@muc.de>
Subject: rbd snap rm error
Date: Fri, 21 Oct 2011 11:41:55 +0200
Message-ID: <CAO47_-9S_72Q3=EZmh9qLgGj_Rt7DkP0VM4onkyrtiMA4zxHxQ@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34869 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab1JUJl5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2011 05:41:57 -0400
Received: by vcge1 with SMTP id e1so3134727vcg.19
        for <ceph-devel@vger.kernel.org>; Fri, 21 Oct 2011 02:41:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

 When I want to delete a snapshot, everything is working, but there is
a strange error message:

# rbd create --size=100 image
# rbd snap create --snap=image-snap1 image
# rbd snap ls image
8       image-snap1     104857600
# rbd snap rm --snap=image-snap1 image
2011-10-21 11:35:58.506393 7f4975f66720 librbd: could not set snap to
: error 2: No such file or directory
2011-10-21 11:35:58.506554 7f4975f66720 librbd: Error re-reading rbd
header: error 2: No such file or directory
# rbd snap ls image
#

The snapshot hat been removed anyway. So this is not a real problem,
it's just irritating.

Kind regards,
Christian
