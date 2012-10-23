From: jie sun <0maidou0@gmail.com>
Subject: some questions about rbd
Date: Tue, 23 Oct 2012 11:10:40 +0800
Message-ID: <CAB6Jr7Q3NcJAFiENv5w=p+DVtZoPksWtQH+cgF4ysHAxMzn6ng@mail.gmail.com>
References: <CAB6Jr7QLS1=G0vPavT70knKUteDczF4yho1Bha_Tgsv1tsXusA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54147 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab2JWDKk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 23:10:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3159948oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 20:10:40 -0700 (PDT)
In-Reply-To: <CAB6Jr7QLS1=G0vPavT70knKUteDczF4yho1Bha_Tgsv1tsXusA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I create a image and map it to a virtual machine,and then mkfs and mount it.

I want to remove the image from mon server forcely, but it says
"Removing image: 99% complete...failed.
 delete error: image still has watchers
 This means the image is still open or the client using it crashed.
Try again after closing/unmapping it or waiting 30s for the crashed
client to timeout."

I want to know is there any other way to remove it by force?

Thank you.
