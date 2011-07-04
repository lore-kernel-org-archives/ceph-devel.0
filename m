From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Question: How does Ceph go from filename to object?
Date: Mon, 04 Jul 2011 19:49:44 +0200
Message-ID: <1309801784.2518.12.camel@wido-laptop.pcextreme.nl>
References: <CANJmCGLt2hPjETaa5bGt71Ewyo4Z-q6XXYsegRUAZNZb-h7J3A@mail.gmail.com>
	 <CANJmCG+HZWWnEmpJ+pY4fjweBckRMPh+b6OiD=kk1egwT9B3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:50139 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab1GDRtr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 13:49:47 -0400
In-Reply-To: <CANJmCG+HZWWnEmpJ+pY4fjweBckRMPh+b6OiD=kk1egwT9B3=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasilakakos Giorgos <sugoruyo@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Mon, 2011-07-04 at 20:17 +0300, Vasilakakos Giorgos wrote:
> Hello folks, I have a question:
> I know files get mapped to objects and those objects to OSDs but how
> exactly do we go from one to the other?
> What I mean is, given the filename I want to access how does Ceph find
> the relevant objects? What exactly does CRUSH do?
> Supposedly, the client first asks the MDS for an inode number, what then?
> How are the object and PG IDs constructed and where exactly does CRUSH come in?
> My impression is that the OID is made from the name, inode and
> probably some kind of information about the striping of the file,
> what about the mapping of an object to a PG?
> Are PGs mapped to OSDs by means of CRUSH, or are objects mapped to PGs
> by CRUSH? How are PGs assigned to OSDs then?
> 
> Could someone clarify this part for me?

Have you read the RADOS, CRUSH and Ceph thesis on the website?

Try:
* http://ceph.newdream.net/weil-thesis.pdf
* http://ceph.newdream.net/papers/weil-rados-pdsw07.pdf
* http://ceph.newdream.net/papers/weil-ceph-osdi06.pdf
* http://ceph.newdream.net/papers/weil-crush-sc06.pdf

I think that should cover most of it.

> 
> Thanks in advance
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


