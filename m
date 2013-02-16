From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Sun, 17 Feb 2013 00:16:40 +0100
Message-ID: <51201358.3010103@mermaidconsulting.dk>
References: <5118C6BF.70207@risc-software.at> <5118FA0D.606@42on.com> <5118FB31.6020902@risc-software.at> <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net> <511D3A35.7090702@mermaidconsulting.dk> <alpine.DEB.2.00.1302141241020.22023@cobra.newdream.net> <511F72D2.5020104@mermaidconsulting.dk> <alpine.DEB.2.00.1302161456480.25660@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.stofanet.dk ([212.10.10.13]:57396 "EHLO mx03.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab3BPXQo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 16 Feb 2013 18:16:44 -0500
In-Reply-To: <alpine.DEB.2.00.1302161456480.25660@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

Hi Sage,

> Would qcow2 let you store the incremental portion of a backup without=
 the=20
> actual image?  A common use case would be:

> - take snapshot1 on cluster A
> - copy image to cluster B, possibly without writing to an intermediat=
e=20
>   file.. e.g. 'rbd export ... - | ssh otherhost rbd import - ...'
> and later,
> - take snapshot2 on cluster A
> - stream snapshot1->2 incremental to cluster B

Well, qcow2 is designed for storing image files on disk, not as a=20
"streamed" file format - so it is not covered by the specification.=20
However, I don't see what should keep us from using it the way you desc=
ribe.

The only drawback is that standard qcow2 tools will not be able to work=
=20
with the incremental file on its own - they would need the base image t=
o=20
be file based.

Basically a qcow2 "incremental" file contains:

  - string holding the path and filename of the backing file
  - lookup table that tells which blocks are included in the file
  - actual data in 512 byte blocks

In this "streaming" case we would not have a path and file to the=20
backing file. Instead we could store something like=20
rbd:pool/imagename@snapname instead of a traditional path and file name=
=2E

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
