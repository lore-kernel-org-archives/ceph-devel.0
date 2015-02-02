From: Stephen Hindle <shindle@llnw.com>
Subject: Minor inconsistency with ceph-deploy on Giant
Date: Mon, 2 Feb 2015 08:19:52 -0700
Message-ID: <CANPbtN-WELLaMUQmoaOZnJ1Q1AUgSiehPLBhDw_yy6d==TfEYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:58806 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753868AbbBBPTx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 10:19:53 -0500
Received: by mail-yk0-f178.google.com with SMTP id q200so22112373ykb.9
        for <ceph-devel@vger.kernel.org>; Mon, 02 Feb 2015 07:19:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

  Just thought I'd mention a minor inconsistency I noticed while
re-installing our cluster...
preparing an OSD with ceph-deploy will NOT activate it on a parttion
(node1:/sda1/sda2)
preparting an OSD with ceph-deploy WILL activate it on a disk (
node1:/dev/sdc)

I think I noticed similiar behavior with ceph-deploy osd create, but I
assumed I just messed up,
so I didnt document it.  This is probably more of an 'issue' as create is
supposed to activate it for you.

Manually issuing a ceph-deploy osd activate works fine to bring the
partition OSDs up.

-- 
The information in this message may be confidential.  It is intended solely 
for
the addressee(s).  If you are not the intended recipient, any disclosure,
copying or distribution of the message, or any action or omission taken by 
you
in reliance on it, is prohibited and may be unlawful.  Please immediately
contact the sender if you have received this message in error.

