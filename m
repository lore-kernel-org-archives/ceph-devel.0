From: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Subject: libcephfs: Open-By-Handle API question
Date: Tue, 4 Jun 2013 10:14:32 +0000
Message-ID: <941FC8BE87ADE64D90E4EB6CD55451770B4DE972@EPBYMINSA0032.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from evbyminsa0039.epam.com ([217.21.63.35]:8218 "EHLO
	EVBYMINSA0039.epam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab3FDKUE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 06:20:04 -0400
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ceph developers,

in order to represent NFS-frontend to CephFS data storage we are trying to use innovative Open-By-Handle API from 'src/include/cephfs/libcephfs.h' file, which is of 'wip-libcephfs' branch at the moment. API looks quite consistent and useful but we couldn't find a method to get a pointer to root inode of the mounted Ceph filesystem.

At the moment we have found only one place, where it could be fetched from: an 'Inode* root' member from the 'Client' class ('src/client/Client.h') but it is in 'protected' section, so some hack is needed (e.g. to introduce a Client's descendant, which is providing a method to acces this protected member). Do you know, how to fetch a pointer to the root inode of the mounted Ceph filesystem without any hacking (using just an official CephFS API only)?

Thank you and best wishes,
Ilya V. Storozhilov
EPAM Systems
Lead Software Engineer

P.S. What do you think about to make 'Open-By-Handle' API to be a primary and not low-level API to CephFS and to make POSIX-like API to be just a helper addendum to it?