From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: uint32_t BlueStore::Extent::logical_offset?
Date: Tue, 22 Nov 2016 18:02:11 -0500 (EST)
Message-ID: <1510551008.49834927.1479855731142.JavaMail.zimbra@redhat.com>
References: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com> <alpine.DEB.2.11.1611222146240.11236@piezo.us.to> <BY2PR02MB39660B0A6749CC3D6AF505EF4B40@BY2PR02MB396.namprd02.prod.outlook.com> <1238161574.49831392.1479854530227.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1611222243240.11236@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:59753 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933146AbcKVXC3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 18:02:29 -0500
In-Reply-To: <alpine.DEB.2.11.1611222243240.11236@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

It would seem like folks attempting to use bluestore in "ways we never thought of" might run into this fairly quickly.  Maybe it's not as much a hard limit as I'm imagining with reference to file systems, though.

Matt

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Somnath Roy" <Somnath.Roy@sandisk.com>, "Igor Fedotov" <ifedotov@mirantis.com>, "ceph-devel"
> <ceph-devel@vger.kernel.org>
> Sent: Tuesday, November 22, 2016 5:45:14 PM
> Subject: Re: uint32_t BlueStore::Extent::logical_offset?
> 
> On Tue, 22 Nov 2016, Matt Benjamin wrote:
> > It would seem preferable not to bake-in such a limit on extent size,
> > even if offsets exceeding that won't immediately be used.
> 
> All things being equal, sure.  But 4gb is 1-2 orders of magnitude larger
> than we recommend or design for, and it costs us memory.
> 
> FWIW, the logical_offset is varint encoded on disk, so the disk format is
> actually unsized.
> 
> In the meantime, I think that 100GB object size limit should really be
> more like 100MB!
> 
> sage
> 
> 
> > 
> > Matt
> > 
> > ----- Original Message -----
> > > From: "Somnath Roy" <Somnath.Roy@sandisk.com>
> > > To: "Sage Weil" <sage@newdream.net>, "Igor Fedotov"
> > > <ifedotov@mirantis.com>
> > > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> > > Sent: Tuesday, November 22, 2016 4:53:18 PM
> > > Subject: RE: uint32_t BlueStore::Extent::logical_offset?
> > > 
> > > Sage,
> > > OSD max obect size in the latest master is 100G , it used to be smaller..
> > > 
> > > OPTION(osd_max_object_size, OPT_U64, 100*1024L*1024L*1024L) // OSD's
> > > maximum
> > > object size
> > > 
> > > Thanks & Regards
> > > Somnath
> > > 
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org
> > > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > > Sent: Tuesday, November 22, 2016 1:47 PM
> > > To: Igor Fedotov
> > > Cc: ceph-devel
> > > Subject: Re: uint32_t BlueStore::Extent::logical_offset?
> > > 
> > > On Tue, 22 Nov 2016, Igor Fedotov wrote:
> > > > Hi Sage,
> > > >
> > > >
> > > > I'm wondering why BlueStore::Extent::logical_offset is 32-bit wide.
> > > >
> > > > IMHO it's to be uint64_t unless we limit onode size to 4Gb.
> > > >
> > > > Looks like we have implicit truncate when doing set_lextent/new Extent
> > > > at the moment and hence some issues with large onodes are possible.
> > > 
> > > The max object size enforced in the OSD is ~128 MB (or in that
> > > neighborhood,
> > > if I remember correctly).  We really shouldn't be storing individual
> > > rados
> > > objects that are orders of magnitude larger than that.
> > > 
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the
> > > body of a message to majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> > > PLEASE NOTE: The information contained in this electronic mail message is
> > > intended only for the use of the designated recipient(s) named above. If
> > > the
> > > reader of this message is not the intended recipient, you are hereby
> > > notified that you have received this message in error and that any
> > > review,
> > > dissemination, distribution, or copying of this message is strictly
> > > prohibited. If you have received this communication in error, please
> > > notify
> > > the sender by telephone or e-mail (as shown above) immediately and
> > > destroy
> > > any and all copies of this message in your possession (whether hard
> > > copies
> > > or electronically stored copies).
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> > --
> > Matt Benjamin
> > Red Hat, Inc.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> > 
> > http://www.redhat.com/en/technologies/storage
> > 
> > tel.  734-821-5101
> > fax.  734-769-8938
> > cel.  734-216-5309
> > 
> > 
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
