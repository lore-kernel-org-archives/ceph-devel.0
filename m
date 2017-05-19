From: =?UTF-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Adaptation of iSCSI-SCST to run entirely in usermode on
 unmodified kernel
Date: Fri, 19 May 2017 11:33:56 +0200
Message-ID: <CAOLwVUnBScqZyojjmf8qYYGvKhpcmyf8tByUfN2aH--53ufNZA@mail.gmail.com>
References: <CALiN7rzE7UcbfgR5UfJVqu062u8onFwSqUYPZ5iaVcbJr5Fv-w@mail.gmail.com>
 <CAOLwVUkPQ0NSZBWH9A=prXUTdx7prVXeCk96NNdypZRtBqoS+A@mail.gmail.com> <CALiN7rwmO0jmE2NTr=sqXJ7QJmssdyi55RAQScB3=1uUyx7TVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35695 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdESJeR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 05:34:17 -0400
Received: by mail-qt0-f181.google.com with SMTP id v27so53796089qtg.2
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 02:34:17 -0700 (PDT)
In-Reply-To: <CALiN7rwmO0jmE2NTr=sqXJ7QJmssdyi55RAQScB3=1uUyx7TVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Butterfield <dab21774@gmail.com>
Cc: Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Adding ceph-devel.

--
Regards,
S=C3=A9bastien Han.


On Sat, May 13, 2017 at 3:28 AM, David Butterfield <dab21774@gmail.com> wro=
te:
> On Mon, Apr 24, 2017 at 6:14 AM, S=C3=A9bastien Han <han.sebastien@gmail.=
com> wrote:
>> Thanks for sharing this David.
>
> Sometime after sending you that I discovered that one of your co-workers
> I have known for about 25 years.
>
>> It looks to me that SCST and LIO are clearly competing with each other.
>> I've just read that article: http://scst.sourceforge.net/scstvslio.html
>> They are pretty rough against LIO (even it seems legit).
>> Can I get your two cents on this?
>
> I wasn't around, but from my reading a little from different sides it
> seems admitted that the decision was ad hominem rather than based
> on technical merit.
>
> I haven't studied LIO enough to evaluate it, but where I would start is t=
o
> look at the last six months of checkin comments and get a feel for how
> stable things are.  (I haven't looked)
>
> What I can tell you is I've been through a large part of the SCST code,
> and a subset of that I've been into quite deeply; and I think it is a ver=
y
> good implementation -- it's a big and complex beast, to match its spec;
> but it is well abstracted and carefully implemented and mostly straight-
> forward, with the tricky places commented, and no fear about going to
> extra trouble to make the performance cases go faster.  I was very
> surprised at how easy it was to pick up 80,000 lines of SCST kernel
> code and run it in usermode without having to change the source.
>
>> It seems that Red Hat (my employer) is leaning toward using LIO + TCMU a=
nd
>> building tcmu-rbd / tcmu-qemu.
>
> Since my earlier message I've written a little interface module to drive
> tcmu-runner backstore handlers from the Usermode-SCST block I/O layer.
> So far I've run it with the tcmu-runner/rbd.c Ceph handler and with a lit=
tle
> "ramdisk" handler I wrote to have a fast device at a strategic point for
> performance testing (the point of crossover to backstore client modules).
>
> I have also built it with QEMU/qcow and Gluster/glfs, but I haven't tried
> running those (not installed).  I did manage to get myself running a litt=
le
> 1-node Ceph "cluster" so I could test using rbd.c  There's a nice
> diagram of all this on the PDF page referenced in the essay below.
>
>> You are work look really similar to the LIO + TCMU approach.
>
> Probably the most important difference is where the datapath transitions
> from kernel mode to usermode and back.  With LIO/TCMU the transport
> layer (iSCSI) runs in the kernel and passes CDBs through the TCMU
> interface to the usermode handler, where SCSI command interpretation
> is done.
>
> In Usermode-SCST the iSCSI layer runs in usermode and the datapath
> transitions from kernel mode to usermode at the socket(7) system calls.
> I believe this difference has performance implications, argued below.
>
> Another interesting difference is running the server in usermode using
> socket calls, it isn't confined to Linux -- FreeBSD could compile it too.
>
> I've written an analysis of this, but I hesitate to send it to the list b=
ecause
> I'm new here and I don't know how sensitive people are likely to be about
> criticism of a project they're working on.  But here's my little essay:
>
>
> iSCSI Support for Usermode Ceph/RBD Clients
> -------------------------------------------
> Here are some observations and opinions regarding support for an iSCSI
> server for Ceph.  Specifically it compares the tcmu-runner approach with
> an alternative approach recently enabled by the adaptation of SCST to
> run as an iSCSI server entirely in usermode.
>
> This alternative was unknown to the Ceph team when they made the
> decision to commit significant effort to implementing a new SCSI server
> in usermode by investing in the development of the tcmu-runner
> framework.  My opinion is that the alternative approach offers
> significantly lower risk to schedule and quality, and would end up
> costing less to develop to enterprise-quality and maintain afterward.
>
> Because of the potential for significant reduction of cost and risk, I
> suggest that the Ceph team reconsider their approach in light of the new
> information.
>
> My two major areas of concern about the approach of using LIO/TCMU are
> code maturity and performance, each discussed in detail below.
>
> Beyond those concerns, a further observation is that running entirely in
> usermode should make it feasible (perhaps even easy) to port this to
> FreeBSD, which appears to be one of the platforms supported by Ceph.
> Supporting iSCSI using Usermode-SCST would allow running the same code
> base on both Linux and FreeBSD; whereas (I assume) LIO does not run on
> FreeBSD, so building a solution around LIO does not seem optimal.
>
> I argue that:
>   o tcmu-runner effort is just beginning in the last couple of months;
>   o the work required to reach enterprise-quality from the current point
>      is quite large and involves substantial schedule risk;
>   o the performance limitations of the approach continue to be unknown
>      and questionable;
>   o the alternative I suggest considering does not have these risks.
>
> Note these arguments have nothing to do with the quality of engineers
> working on the implementation, which I assume is high and appears to be
> so.  I also assume the goal is to provide enterprise-quality iSCSI servic=
e
> commensurate with the quality goals of other Ceph services.
>
> This PDF page may be helpful in visualizing the differences in approach
> discussed below.  The diagram on the left is for background, and compares
> SCST running in the kernel with SCST running in usermode.  The diagram
> on the right shows the datapath for both LIO and Usermode-SCST connecting
> iSCSI initiators with backstore client modules (e.g. tcmu-runner/rbd.c).
>
> https://github.com/DavidButterfield/SCST-Usermode-Adaptation/blob/scstu_t=
cmu/usermode/scstu_tcmur.pdf
>
> Code Maturity
> -------------
> We know risk associates with the (lack of) maturity level of a body of co=
de.
> Observing the checkin comments from April to May 6, 2017: it appears a
> new SCSI command processing server is being built from the ground up,
> function by function, within the usermode tcmu-runner implementation.
>
> It seems likely this would be done using parts taken from the kernel
> LIO implementation -- but it is not going in as a monolithic chunk of
> debugged code, but rather as snippets carved from one implementation
> and assembled into another.  This preserves little of the effective
> maturity of the older implementation in creating the new.
>
> The recovery protocols are subtle and you have to figure out what's
> going on in the wild as well as what's in the specs.  And even if you've
> done it before so you think you know all the gotchas, by the time you
> do it again there are new revisions of the specs with new ambiguities
> to resolve, and new versions of third-party initiators with new quirks
> to figure out and interoperate with.
>
> Even worse, many of the hardest problems become apparent after the
> code is in the field, as user installations begin to exercise rarely-exec=
uted
> recovery protocols that must interoperate adequately with all versions
> of all the important third-party initiators (e.g. ESX, etc).  This leads
> to unplanned costs to debug the hard issues and "maintain it into shape".
>
> As someone familiar with the protocols, to me the checkin comments also
> indicate an implementation at a fairly early functionality stage.  Based =
on
> several years working on a distributed replicated iSCSI server, my opinio=
n
> is that it is going to be a long time before that code reliably works wit=
h all
> the other important protocol implementations under all the various failur=
e
> conditions.
>
> In contrast, the Usermode-SCST alternative brings the entire SCST server
> core and its relevant transport and storage modules to usermode as an
> intact whole, operating together in the same way they do for the same
> configuration when kernel-resident.  This completely preserves the
> maturity of the implementation of the iSCSI, SPC, and SBC protocols --
> with all the subtle aspects already baked-in after many years of running
> in-kernel -- maturity preserved by adapting SCST to run in usermode as a
> whole without making any changes to the logic.
>
> This solution leverages 80,000 lines of a very mature iSCSI/SCSI
> implementation, saving much work in an area that may or may not be
> directly within the Ceph team's preferred area of focus or development
> of expertise.
>
> Of course, this alternative has its own risk related to new code: the
> code I wrote to simulate the kernel calls made by the SCST logic.  This
> code is not perfect and would require some work to bring up to product
> quality (such as changing some assertions into error returns; a thorough
> review by another engineer or two; and considering possible issues
> marked in the code with "XXX" comments.  But it runs fine and can
> keep a 1 Gb network saturated using less than a 2 GHz CPU thread.
>
> I argue the cost and schedule and quality risks here are *much* smaller
> than implementing a new SCSI server, for these reasons:
>
>   o It's only 10,000 lines of code, most places well commented.
>
>   o Much of that code is straightforward utility functions.
>
>   o The tricky code is not "tricky protocol stuff" well-understood by a
>      few specialists; it's "tricky system stuff emulating particular Linu=
x
>      kernel functionality", whose semantics are understood by a much
>      larger population of Linux kernel programmers.  This makes a
>      thorough review of it much easier, and availability of a broader
>      pool of engineers to draw from for ongoing maintenance.
>
>   o It's only 10,000 lines of code, to import 80,000 lines of solid
>      protocol code unchanged.  It would be cheaper to rewrite your own
>      kernel simulation code completely from scratch than to build a
>      fully-functional SCSI server.  (But mine already runs, so it would
>      be much less trouble than that.)
>
> Performance
> -----------
> Caveat: the following analysis is based only on considering the TCMU
> model, not any actual experimentation.
>
> The "ring" that mediates communication between tcm_user (in the kernel)
> and libtcmu (in userspace) looks nice on paper; but the performance
> devil is in the details.  This is the point where the datapath crosses
> from the kernel into userspace (and back).  The problem isn't contention
> for access to the ring; the problem is the timely scheduling of the
> threads on each side of the ring.
>
> Another performance-related aspect of the TCMU model is that the
> granularity of the transactions between the kernel and usermode is the
> CDB.  There is overhead cost to access and maintain the ring four times
> per SCSI command (Request+Response) * (Transmit+Receive).
>
> But worse is the thought of at least one wakeup per command on average,
> because one side has to be faster and it must inevitably sleep (or
> spin-poll).  In practice it ends up being fewer than one wakeup per OP
> because backlog accumulates in some queue during the scheduling delay,
> which can all be processed in one wakeup.  But you only get that in
> compensation for enduring a scheduling latency (with its own issues).
>
> This performance concern is not specifically about tcmu-runner, but
> about TCMU itself, which has had a longer time to gain userspace
> clients.  Finding even one such client that has been well-measured under
> a variety of conditions and demonstrated to work reliably with high
> performance would substantially reduce this concern.  There may be one
> out there, but I looked around and did not find anything except like
> "we haven't done performance tuning yet".  I think there is at least one
> devil in that detail.
>
> As far as I have found, the performance capabilities and limitations of
> the TCMU interface are unproven and unknown.  How many IOPS can get
> through that ring, and what happens if the load is not quite 100%, or
> the load is light at queue-depth 2 or even 1?  Or when the required
> protocol work is heavier on the kernel side versus heavier on the
> usermode side?  The concern relates to factors that are at least partly
> inherent in the model, not amenable to simple "tuning at the end".
>
> So, is there even *one* example of a TCMU client out there that behaves
> well and gives high performance to prove that it is possible to do so
> through TCMU?
>
> To consider the alternative: Usermode-SCST uses socket(2) and related
> system calls for network I/O to the iSCSI initiator.  In the Usermode-
> SCST model, these socket calls are where the datapath crosses from the
> kernel into userspace.  Here the granularity of transaction between
> kernel and user can be as large as the socket buffer size -- much larger
> than one SCSI command.  Under moderate loads (sufficient queue-depth)
> use of large socket I/O is much more efficient than doing I/O for each
> SCSI command individually.
>
> Note: the implementation of Usermode-SCST in my repository does not have
> the large-socket-I/O work, which is prototyped in an older tree on my
> workstation.  All the performance measurements in my paper were done
> with the code in the repository, without this improvement.  The large-
> I/O improvement is ripe to be updated and integrated when I get time.
>
> But the TCMU model is not amenable to this approach -- its transactions
> are inherently CDB-oriented.  I expect the TCMU IOPS bottleneck is going
> to be around that ring -- unless some previous project has already gone
> through this and made it otherwise.
>
> Regards,
> Dave Butterfield
