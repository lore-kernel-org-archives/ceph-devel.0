From: huang jun <hjwsm1989@gmail.com>
Subject: the osd overload result in mds cannot reply client quickly
Date: Tue, 19 Apr 2011 17:56:32 +0800
Message-ID: <BANLkTin6RVew30zBExj55-LftkScudg=EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:58889 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1DSJ4e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2011 05:56:34 -0400
Received: by wwk4 with SMTP id 4so2766297wwk.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2011 02:56:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,developers
    i mount a new client and create a new directory when the osds are
overload. in gerenal ,mds needs to return a safe
message to the client( not return unsafe message to client at this
time), but in this condition(OSD overloads) ,it takes too long to wait
for OSD finish  OSD_Op ,so the MDS can not immediatly answer the
client the safe message, is there any resolutions about this problem?
if did, in which model should  i  try it ,OSD or MDS?

thanks !
