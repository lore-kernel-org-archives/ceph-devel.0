From: Robert LeBlanc <robert@leblancnet.us>
Subject: Multiple OSDs suicide because of client issues?
Date: Sat, 21 Nov 2015 00:34:04 -0700
Message-ID: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34832 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbbKUHeG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Nov 2015 02:34:06 -0500
Received: by vkha189 with SMTP id a189so11288000vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 20 Nov 2015 23:34:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

We had two interesting issues today. In both cases multiple OSDs
suicided at the exact same moment. The first incident had four OSDs,
the second had 12.

First set:
145,159,79,176

Second Set:
osd.177 down at 20:59:48,
osd.131, osd.136, osd.133, osd.139, osd.175, osd.170, osd.73 down at 20:00:03,
osd.178, osd.179 down at 21:00:07,
osd.159 down at 21:01:22,
osd.110 down at 21:01:28

Only one OSD failed both times and only a couple of boxes had more
than one OSD fail. The failures were spread out throughout the
cluster. There is nothing in dmesg/messages/sar that indicate there
was any type of hardware problem on the OSD hosts. All the OSDs
indicate slow I/O and heartbeats missing starting at 20:57:32.

The other odd thing is that most of the VMs across our 16 KVM hosts
were fine, but several VMs on one host had kernel panics. In the
messages logs of that host we see a kernel backtrace:

Nov 20 20:58:32 compute8 kernel: WARNING: CPU: 4 PID: 0 at
net/core/dev.c:2223 skb_warn_bad_offload+0xb6/0xbd()

That host's clock was exactly one minute fast. Everything points to
this host as having the issue, but I'm having a hard time
understanding how a client (or several clients) could cause several
OSDs to suicide. Can a non-responsive client in some way cause the OSD
to fault?

We have migrated all the VMs off this host and will continue to
monitor the cluster. If there is interest in the logs (librbd did not
dump any logs) from the OSDs, I can make them available.

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWUB5pCRDmVDuy+mK58QAAXbIP/jZyfbAalXRr4dFpEU4n
OL5X0vBLCeg1UMbXjBRXbWlrUKHBvkruU0JCWEWEb9FFDfdkEggYwZazUVx/
b3LU8LUGWD56wtaho8/V9FbDPsRD943k6TC+FoF4TL/FFuuiJ/Elnt97Fkkg
xSBTKWS3p0I7PpSrefX+lUsDMzWJ1n6HTlYnE8SmlkkOgudh4IFFRObrv0Yr
VPOzcD3RQULdFhEdtNZYUfVudypfKz1uFyq/FtgMSQbiHeQTn0JgD6ykWKZg
9VWAVIUiHjyQn97KasCwpJjc2Vab5cUKJuUzLg72WlEKV/Q8rRcqHmxP10Pm
+h30G2N1F9JsDmEeFtYNdd/AcvsoDIRaqQ7GzJf99sJAbLQCY9VT/LWd5H52
PPUtRTHU8pr78rtVdOtQG1sxOZHvaNpPM9MQYnoxRkiCixazbO6dWVmuq32S
iEaom2J1jNxUE+RUxHMVtb+qv4jOEMHBGpdragajslqiWKZrvtsPfVyn/E0s
8m3nj67jkN4xMro3/fRJqeLUqc6QHAN/BXoTMm7flzFJyQ1fZ1l/Up8xR07J
5xtl15vOf2Xa+IVFYPkLOoV+J/mTNiIQYaQKnkqYkL2OcbOq88TFHPUJ011+
SegMD1aIYCUjLYbq+DVqarsnsJbSC51B6aR5Ko+ZOvHyMYYyRPfU4DBqGWO/
GlcH
=sFlz
-----END PGP SIGNATURE-----
