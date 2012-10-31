From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph journal
Date: Wed, 31 Oct 2012 23:55:27 +0100
Message-ID: <CAOLwVU=kQ+-XjAe1e8dFhUEXSV4i+tQc+S46LrUAtPtZQ3t2gQ@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
 <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
 <CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
 <5091A06E.20407@kleijkers.nl> <CAJH6TXgn4JDJ_gLJGzoeFkMaU5qgREW8EEqWj5yh2AtPQjzrhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46024 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab2JaWzt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 18:55:49 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1477061lbo.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 15:55:48 -0700 (PDT)
In-Reply-To: <CAJH6TXgn4JDJ_gLJGzoeFkMaU5qgREW8EEqWj5yh2AtPQjzrhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Stefan Kleijkers <stefan@kleijkers.nl>, Tren Blackburn <tren@eotnetworks.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Personally I won't take the risk to loose transactions. If a client
writes into a journal, assuming it's the first write and if the server
crashs for whatever reason, you have high risk of un-consistent data.
Because you just lost what was in the journal.
Tmpfs is the cheapest solution for achieving better performance, but
it's definitely not the most reliable. Keep in mind that you don't
really want to see your load/data balancing through the cluster while
recovering from a failure...
At last resort, I will use the root filesystem if it's decently fast
to store the journals.

My 2 cents...

Cheers!

--
Bien cordialement.
S=E9bastien HAN.



On Wed, Oct 31, 2012 at 11:07 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
>
> 2012/10/31 Stefan Kleijkers <stefan@kleijkers.nl>:
> > As far as I know, this is correct. You get a ACK (on the write) bac=
k after
> > it landed on ALL three journals (or/and osds in case of BTRFS in pa=
rallel
> > mode). So If you lose one node, you still have it in two more nodes=
 and they
> > will commit it to disk. After recovering the missing node/osd it wi=
ll get
> > the data from one of the other nodes. So you won't lose any data.
>
> Sounds perfect, this will allow me to avoid SSD disks and using al 12
> disks on a DELL R515 as OSD
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
