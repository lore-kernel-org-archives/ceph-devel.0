From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: [Gluster-devel] Introducing Tendrl
Date: Tue, 20 Sep 2016 19:52:54 +0300
Message-ID: <c89afa54-57b5-3977-2d43-fa730e932a79@redhat.com>
References: <CAOLAhP1dRqPFuVNPuOXfSktQdHEmuX-88iPb94RkWkm6AbS4+w@mail.gmail.com>
 <CAGrH30W5nz8hb+RcUt+gSPJRPUJ4ptLn2goc-EWsqapBKJSCfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932692AbcITQxA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Sep 2016 12:53:00 -0400
In-Reply-To: <CAGrH30W5nz8hb+RcUt+gSPJRPUJ4ptLn2goc-EWsqapBKJSCfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gerard Braad <me@gbraad.nl>, Mrugesh Karnik <mkarnik@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gluster Development <gluster-devel@gluster.org>

On 09/20/2016 10:23 AM, Gerard Braad wrote:
> Hi Mrugesh,
>
> On Tue, Sep 20, 2016 at 3:10 PM, Mrugesh Karnik <mkarnik@redhat.com> wrote:
>> I'd like to introduce the Tendrl project. Tendrl aims to build a
>> management interface for Ceph. We've pushed some documentation to the
> On Tue, Sep 20, 2016 at 3:15 PM, Mrugesh Karnik <mkarnik@redhat.com> wrote:
>> I'd like to introduce the Tendrl project. Tendrl aims to build a
>> management interface for Gluster. We've pushed some documentation to
> It might help to introduce Tendrl as the "Universal Storage Manager'"
> with a possibility to either manage Ceph and/or Gluster.
> I understand you want specific feedback, but a clear definition of the
> tool would be helpful.
>

(Apologies for reposting my response - gmail injected html into what I thought 
was a text reply and it bounced from ceph-devel.)

Hi Gerard,

I see the goal differently.

It is better to think of tendryl as one component of a whole management 
application stack. At the bottom, we will have ceph specific components 
(ceph-mgr) and gluster specific components (glusterd), as well as other local 
storage/file system components like libstoragemgt and so on.

Tendryl is the next layer up from that, but it itself is meant to be consumed by 
presentation layers. For a stand alone thing that we hope to use at Red Hat, 
there will be a universal storage manager stack with everything I mentioned 
above in it, as well as the GUI code.

Other projects will hopefully find this useful enough and plug some or all of 
the components into other management stacks.

 From my point of view, the job is to try to provide as much as possible 
re-usable components that will be generically interesting to a wide variety of 
applications. It is definitely not about trying to make all storage stacks look 
the same and force artificial new names/concepts/etc on the users. Of course, 
any one application will tend to have a similar "skin" for UX elements to try 
and make it consistent for users.

If we do it right, people passionate about Ceph but who don't care about Gluster 
will be able to be avoid getting tied up in something out of their interest. 
Same going the other way around for Gluster developers who don't care or know 
about Ceph. Over time, this might extend to other storage types like Samba or 
NFS Ganesha clusters, etc.

Regards,

Ric




