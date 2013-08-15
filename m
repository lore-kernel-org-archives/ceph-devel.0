From: Wido den Hollander <wido@42on.com>
Subject: Need some help with the RBD Java bindings
Date: Thu, 15 Aug 2013 17:51:39 +0200
Message-ID: <520CF90B.2070106@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:51878 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757460Ab3HOPvo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Aug 2013 11:51:44 -0400
Received: from [IPv6:2001:980:7936:0:54f5:7c0a:be60:558d] (unknown [IPv6:2001:980:7936:0:54f5:7c0a:be60:558d])
	by websrv.42on.com (Postfix) with ESMTPSA id 4E26BC44EE
	for <ceph-devel@vger.kernel.org>; Thu, 15 Aug 2013 17:51:39 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm having some issues with the Java bindings for librbd and I'm not 
sure what the problem is here.

The problem is with listing snapshot of a RBD image. I test it in this 
test case:

public void testCreateAndClone() {
     try {
         ..
         ..
         image.snapCreate(snapName);
         image.snapProtect(snapName);

         List<RbdSnapInfo> snaps = image.snapList();
         assertEquals("There should only be one snapshot", 1, snaps.size());
     ..
     ..
     }
}

This test fails 95% of the time with my whole JVM crashing.

The code to blame is in RbdImage.java:

public List<RbdSnapInfo> snapList() throws RbdException {
     IntByReference numSnaps = new IntByReference(16);
     PointerByReference snaps = new PointerByReference();
     List<RbdSnapInfo> list = new ArrayList<RbdSnapInfo>();
     RbdSnapInfo snapInfo, snapInfos[];

     while (true) {
         int r = rbd.rbd_snap_list(this.getPointer(), snaps, numSnaps);
         if (r >= 0) {
             numSnaps.setValue(r);
             break;
         } else {
             throw new RbdException("Failed listing snapshots", r);
         }
     }

     Pointer p = snaps.getValue(); <<<< crash
     snapInfo = new RbdSnapInfo(p);

     ..
     ..
}

So it crashes when it wants to get the value of the snaps var.

I can't figure out why this is happening and why it isn't consistent. 
I'm not a real JNA expert and I was hoping somebody around here would be 
able to figure out what I'm doing wrong.

Any Java/JNA experts around who might have a clue?

The source of rados-java: https://github.com/wido/rados-java

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
