From: Jens Rehpoehler <jens.rehpoehler@filoo.de>
Subject: ceph -w output
Date: Mon, 12 Dec 2011 20:23:15 +0100
Message-ID: <4EE654A3.1040309@filoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060403090301070707020803"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-6.de-punkt.de ([93.190.64.36]:56765 "EHLO
	mail-6.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab1LLT3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2011 14:29:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403090301070707020803
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

could someone please explain to following to me:

2011-12-12 20:16:16.899140    pg v182377: 1190 pgs: 18 creating, 1172 
active+clean; 332 GB data, 652 GB used, 13270 GB / 14667 GB avail
2011-12-12 20:16:20.769268    pg v182378: 1190 pgs: 18 creating, 1172 
active+clean; 332 GB data, 652 GB used, 13270 GB / 14667 GB avail

I've created the filesystem a week ago. The Status "18 creating" remains 
since then. I've another Cluster where "creating" never shows up.

Anything to worry about ? Any chance to debug this ?

Thanks a lot !!

Jens

PS: it's the first time i write to a list. please be patient with me if 
i break any rules :)

--------------060403090301070707020803
Content-Type: text/x-vcard; charset=utf-8;
 name="jens_rehpoehler.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jens_rehpoehler.vcf"

begin:vcard
fn;quoted-printable:Jens Rehp=C3=B6hler
n;quoted-printable:Rehp=C3=B6hler;Jens
org:Filoo GmbH
adr:;;Tilsiter Str. 1;Langenberg;NRW;33449;Deutschland
email;internet:jens.rehpoehler@filoo.de
tel;work:+49-5248-1898412
tel;fax:+49-5248-189819
tel;cell:+49-151-54645798
url:www.filoo.de
version:2.1
end:vcard


--------------060403090301070707020803--
