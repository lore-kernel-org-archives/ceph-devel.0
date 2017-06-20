From: Sage Weil <sweil@redhat.com>
Subject: Re: Caught the first erroneous translated errorcode
Date: Tue, 20 Jun 2017 02:35:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706200235310.32269@piezo.novalocal>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl> <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com> <5ca934f2-0f95-bb6c-0fce-267468cb59b4@digiware.nl> <028757af-a82b-d873-648d-294961984bbb@digiware.nl>
 <CA+aFP1BST9e4UV6kyxP=kLN0tN0=1EkV=41cBV2Y5d98hrED7A@mail.gmail.com> <95b2bd08-f38b-f5ff-ebfc-523dddb1398b@digiware.nl> <alpine.DEB.2.11.1706191430290.32269@piezo.novalocal> <6ec50c30-420b-2039-9af3-184665177149@digiware.nl>
 <CAJ4mKGaQWJk7dghda6pVOt2g0RfiTh7dw4t8mcqvsRoiR80Rog@mail.gmail.com> <e16d4ec0-7aa1-a793-80dc-4b46a0eb0793@digiware.nl> <748ac281-3574-e9dc-e421-b8863d70f34e@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdFTCft (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Jun 2017 22:35:49 -0400
In-Reply-To: <748ac281-3574-e9dc-e421-b8863d70f34e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Try changing

  int32_t rval;

in OSDOp in osd_types.h to errorcode32_t.

sage


On Tue, 20 Jun 2017, Willem Jan Withagen wrote:

> On 19-6-2017 17:45, Willem Jan Withagen wrote:
> > On 19-6-2017 16:55, Gregory Farnum wrote:
> >> On Mon, Jun 19, 2017 at 7:46 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> >>> Op 19-6-2017 om 16:31 schreef Sage Weil:
> >>>>
> >>>> On Mon, 19 Jun 2017, Willem Jan Withagen wrote:
> >>>>>
> >>>>> On 19-6-2017 14:56, Jason Dillaman wrote:
> >>>>>>
> >>>>>> On Sun, Jun 18, 2017 at 1:18 PM, Willem Jan Withagen <wjw@digiware.nl>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> librbd/io/AioCompletion.cc:199:ssize_t
> >>>>>>> AioCompletion::get_return_value() {
> >>>>>>
> >>>>>>
> >>>>>> librbd just wraps librados, so I would think all the error codes
> >>>>>> should have already been properly translated before it reaches this
> >>>>>> level since otherwise any internal librbd error logging will output
> >>>>>> the incorrect failure reason. I'd suspect most of the client-side
> >>>>>> handling should probably be handled inside osdc/Objecter.h/cc..
> >>>>>
> >>>>> Hi Jason,
> >>>>>
> >>>>> Thanx for the pointer. Changing any of the librbd stuff did indeed not
> >>>>> result in a working rados-stripper.sh
> >>>>>
> >>>>> Objecter.{h,cc} already had the forward error rewrite. I added the
> >>>>> reverse in the original patch. But obviously that is not enough (yet)
> >>>>> So I'll start digging a bit more in the librados files as you suggested.
> >>>>
> >>>> I think the place to do this is in MOSDOpReply.. that alone should be
> >>>> enough to do the translate as the value passes over the wire.
> >>>
> >>>
> >>> Hi Sage,
> >>>
> >>> Tehe interesting part of this is that ALL tests but one actually work. So
> >>> all tests that start
> >>> a cluster thru vstart actually do work. EXCEPT for rados-stiper.sh.
> >>>
> >>> Now this make me question what is different with the stiper code that causes
> >>> an ECANCEL
> >>> to not be translated back ot FreeBSD code.
> >>
> >> I'm not sure exactly how it's arranged, but libradosstriper is layered
> >> on top of librados and I don't think anybody's done any of the errno
> >> translation work for other platforms that you got pointed at.
> >> Depending on how it's done that may mean it's missing big chunks --
> >> for instance, if libradosstriper embeds error codes that aren't
> >> touched by librados, it will need to do its own translation.
> > 
> > Hi Greg,
> > 
> > The error is on the path server -> client.
> > 
> > How do I know: FreeBSD highest error number atm is 96.
> > ECANCELD is an expected return value in the stiper-code.
> > So server-side  translation seems to be doing what it should.
> > Client-side code is:
> > 
> > 1260 ./src/libradosstriper/RadosStriperImpl.cc
> > ====
> >   bl.append(oss.str());
> >   writeOp.setxattr(XATTR_SIZE, bl);
> >   rc = m_ioCtx.operate(firstObjOid, &writeOp);
> >   // return current size
> >   *size = curSize;
> >   // handle case where objectsize is already bigger than size
> >   if (-ECANCELED == rc)
> >     rc = 0;
> >   if (rc) {
> >     unlockObject(soid, *lockCookie);
> >     lderr(cct()) << "RadosStriperImpl::openStripedObjectForWrite : "
> >                    << "could not set new size for "
> >                    << soid << " : rc = " << rc << dendl;
> >   }
> >   return rc;
> > ====
> > 
> > So I have ot drill down into m_ioCtx.operate.
> > But I'll first look at Sage's suggestion.
> 
> Have not been able to find the right spot....
> So uped the logging, and this is the first place where any reference to
> -125 is made:
> 116: 2017-06-20 01:24:21.556950 80fc18800  5 -- 127.0.0.1:0/1969737172
> >> 127.0.0.1:6804/60048 conn(0x81065c000 :-1 s=STATE_OPEN
> _MESSAGE_READ_FOOTER_AND_DISPATCH pgs=2 cs=1 l=1). rx osd.1 seq 6
> 0x810696e00 osd_op_reply(5 toyfile.0000000000000000 [cmpxattr
> (8) op 3 mode 2,setxattr (4)] v19'4 uv3 ondisk = -125 ((125) Unknown
> error: 125)) v8
> 116: 2017-06-20 01:24:21.556985 80fc18800  1 -- 127.0.0.1:0/1969737172
> <== osd.1 127.0.0.1:6804/60048 6 ==== osd_op_reply(5 toyf
> ile.0000000000000000 [cmpxattr (8) op 3 mode 2,setxattr (4)] v19'4 uv3
> ondisk = -125 ((125) Unknown error: 125)) v8 ==== 210+0+0
>  (669224781 0 0) 0x810696e00 con 0x81065c000
> 116: 2017-06-20 01:24:21.557009 80fc18800 10 client.4115.objecter
> ms_dispatch 0x80fc33000 osd_op_reply(5 toyfile.000000000000000
> 0 [cmpxattr (8) op 3 mode 2,setxattr (4)] v19'4 uv3 ondisk = -125 ((125)
> Unknown error: 125)) v8
> 116: 2017-06-20 01:24:21.557024 80fc18800 10 client.4115.objecter in
> handle_osd_op_reply
> 116: 2017-06-20 01:24:21.557031 80fc18800  7 client.4115.objecter
> handle_osd_op_reply 5 ondisk uv 3 in 1.3 attempt 0
> 116: 2017-06-20 01:24:21.557038 80fc18800 10 client.4115.objecter  op 0
> rval -85 len 0
> 116: 2017-06-20 01:24:21.557043 80fc18800 10 client.4115.objecter  op 1
> rval 0 len 0
> 116: 2017-06-20 01:24:21.557047 80fc18800 15 client.4115.objecter
> handle_osd_op_reply completed tid 5
> 116: 2017-06-20 01:24:21.557050 80fc18800 15 client.4115.objecter
> finish_op 5
> 116: 2017-06-20 01:24:21.557056 80fc18800 20 client.4115.objecter
> put_session s=0x810695800 osd=1 4
> 116: 2017-06-20 01:24:21.557060 80fc18800 15 client.4115.objecter
> _session_op_remove 1 5
> 116: 2017-06-20 01:24:21.557073 80fc18800  5 client.4115.objecter 0 in
> flight
> 116: 2017-06-20 01:24:21.557085 80fc18800 20 client.4115.objecter
> put_session s=0x810695800 osd=1 3
> 
> This make me wonder and now the question is if this osd_reply contains
> the numeric error value or is it a formatted text error report of some
> event on the server and there is already a translation problem on the
> server, and not in the client.
> 
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
