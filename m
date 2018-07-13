From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: upgrading to 12.2.6 damages cephfs (crc errors)
Date: Fri, 13 Jul 2018 13:01:18 +0200
Message-ID: <CABZ+qqn0JOZyf-BceSR5eTnb3oo_R9Brt-BJJ+stmx2CrZZ1HQ@mail.gmail.com>
References: <CABZ+qqkdGn0Ruu7caosOPCyu0AoAgN9raY6V+25vg-6HKjfrKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqkdGn0Ruu7caosOPCyu0AoAgN9raY6V+25vg-6HKjfrKw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

The problem seems similar to https://tracker.ceph.com/issues/23871
which was fixed in mimic but not luminous:

fe5038c7f9 osd/PrimaryLogPG: clear data digest on WRITEFULL if skip_data_digest

.. dan
On Fri, Jul 13, 2018 at 12:45 PM Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
>
> Hi,
>
> Following the reports on ceph-users about damaged cephfs after
> updating to 12.2.6 I spun up a 1 node cluster to try the upgrade.
> I started with two OSDs on 12.2.5, wrote some data.
> Then I restarted the OSDs one by one while continuing to write to the
> cephfs mountpoint.
> Then I restarted the (single) MDS, and it is indeed damaged with a crc error:
>
> 2018-07-13 12:38:55.261379 osd.1 osd.1 137.138.62.86:6805/35320 2 :
> cluster [ERR] 2.15 full-object read crc 0xed77af7c != expected
> 0x1a1d319d on 2:aa448500:::500.00000000:head
> 2018-07-13 12:38:55.285994 osd.0 osd.0 137.138.62.86:6801/34755 2 :
> cluster [ERR] 2.13 full-object read crc 0xa73a97ef != expected
> 0x3e6fdb4a on 2:c91d4a1d:::mds0_inotable:head
>
> I think it goes without saying that nobody should upgrade a cephfs to
> 12.2.6 until this is understood.
>
> -- Dan
