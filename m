From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: Fwd: Need some help in setting up rbd image with kvm
Date: Tue, 14 Feb 2012 18:17:16 +0530
Message-ID: <CAHbZLqQXSbsW2zUeDFwvXSr-+siY35sBy5xDye+9TNUbOVHxDw@mail.gmail.com>
References: <CAHbZLqR9FxoTLmLvEMBxtsvzb_jfGDBw8pdCnH_S12FQCifVLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:52005 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755290Ab2BNMrQ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Feb 2012 07:47:16 -0500
Received: by obcva7 with SMTP id va7so8056333obc.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 04:47:16 -0800 (PST)
In-Reply-To: <CAHbZLqR9FxoTLmLvEMBxtsvzb_jfGDBw8pdCnH_S12FQCifVLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Also Including ceph team


Hi Dan,

I was following your post of

Setting up a Ceph cluster and exporting a RBD volume to a KVM guest.

I have few questions,
What does mkcepfs do? (A per my understanding from your post ,it is
used to to initialize filesystem/object store)
How is object store initialized ? (If not the above how does it do)
When we trigger mount ,it is like having a file system ?
Is it correct to create a rbd device on top of this filesystem.(I am
confused about this.)Bock device is something which we have instead of
filesystem.

Can we create a rbd device without filesystem mounted and can it be a
shared device.

Please help me.

Thank you


=A0--
Thanks and Regards,
Upendra.M




--
Thanks and Regards,
Upendra.M

As a leading developer of IT infrastructure software solutions,
Hexagrid developed the first cloud computing platform that directly
aligns with the real-world IT delivery models of both solution
providers and enterprises. Hexagrid provides all the software and
support that IT organizations need to successfully build public,
private, or hybrid clouds that fit their specific business and
end-user requirements. Hexagrid cloud solutions truly simplify and
expedite virtual IT management, empowering successful cloud computing
strategies that quickly increase profits by pooling resources,
delivering control, and building value. Our Software, Your Cloud.=A0 Fo=
r
more information, visit www.hexagrid.com and follow @Hexagrid on
Twitter
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
