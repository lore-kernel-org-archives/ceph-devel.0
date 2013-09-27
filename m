From: Travis Rhoden <trhoden-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RBD Snap removal priority
Date: Fri, 27 Sep 2013 15:37:56 -0400
Message-ID: <CACkq2mqUx5L-eZeW9Uq9xdtzC_busoVzoya7h4P1JNAz+9iRNw@mail.gmail.com>
References: <CACkq2mqCDvuRdCV-=gEwVNEke-UchOqSsNA=+z-Tux5xWhsa9w@mail.gmail.com>
	<5245C8E6.9000305@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5245C8E6.9000305-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Mike Dawson <mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Mike,

Thanks for the info.  I had seem some of the previous reports of
reduced performance during various recovery tasks (and certainly
experienced them) but you summarized them all quite nicely.

Yes, I'm running XFS on the OSDs.  I checked fragmentation on a few of
my OSDs -- all came back ~38% (better than I thought!).

 - Travis

On Fri, Sep 27, 2013 at 2:05 PM, Mike Dawson <mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org> wrote:
> [cc ceph-devel]
>
> Travis,
>
> RBD doesn't behave well when Ceph maintainance operations create spindle
> contention (i.e. 100% util from iostat). More about that below.
>
> Do you run XFS under your OSDs? If so, can you check for extent
> fragmentation? Should be something like:
>
> xfs_db -c frag -r /dev/sdb1
>
> We recently saw a fragmentation factors of over 80%, with lots of ino's
> having hundreds of extents. After 24 hours+ of defrag'ing, we got it under
> control, but we're seeing the fragmentation factor grow by ~1.5% daily. We
> experienced spindle contention issues even after the defrag.
>
>
>
> Sage, Sam, etc,
>
> I think the real issue is Ceph has several states where it performs what I
> would call "maintanance operations" that saturate the underlying storage
> without properly yielding to client i/o (which should have a higher
> priority).
>
> I have experienced or seen reports of Ceph maintainance affecting rbd client
> i/o in many ways:
>
> - QEMU/RBD Client I/O Stalls or Halts Due to Spindle Contention from Ceph
> Maintainance [1]
> - Recovery and/or Backfill Cause QEMU/RBD Reads to Hang [2]
> - rbd snap rm (Travis' report below)
>
> [1] http://tracker.ceph.com/issues/6278
> [2] http://tracker.ceph.com/issues/6333
>
> I think this family of issues speak to the need for Ceph to have more
> visibility into the underlying storage's limitations (especially spindle
> contention) when performing known expensive maintainance operations.
>
> Thanks,
> Mike Dawson
>
>
> On 9/27/2013 12:25 PM, Travis Rhoden wrote:
>>
>> Hello everyone,
>>
>> I'm running a Cuttlefish cluster that hosts a lot of RBDs.  I recently
>> removed a snapshot of a large one (rbd snap rm -- 12TB), and I noticed
>> that all of the clients had markedly decreased performance.  Looking
>> at iostat on the OSD nodes had most disks pegged at 100% util.
>>
>> I know there are thread priorities that can be set for clients vs
>> recovery, but I'm not sure what deleting a snapshot falls under.  I
>> couldn't really find anything relevant.  Is there anything I can tweak
>> to lower the priority of such an operation?  I didn't need it to
>> complete fast, as "rbd snap rm" returns immediately and the actual
>> deletion is done asynchronously.  I'd be fine with it taking longer at
>> a lower priority, but as it stands now it brings my cluster to a crawl
>> and is causing issues with several VMs.
>>
>> I see an "osd snap trim thread timeout" option in the docs -- Is the
>> operation occuring here what you would call snap trimming?  If so, any
>> chance of adding an option for "osd snap trim priority" just like
>> there is for osd client op and osd recovery op?
>>
>> Hope what I am saying makes sense...
>>
>>   - Travis
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
