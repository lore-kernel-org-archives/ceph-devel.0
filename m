From: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Subject: Re: killing ceph-disk [was Re: ceph-volume: migration
 and disk partition support]
Date: Tue, 17 Oct 2017 08:25:32 +0900
Message-ID: <20171017082532.1de8b6a3@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1710091448500.26711@piezo.us.to>
 <dae3fb33-f7ac-454b-9a3c-1c311ab8ce71@zimbra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <dae3fb33-f7ac-454b-9a3c-1c311ab8ce71@zimbra>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, 16 Oct 2017 18:32:06 -0400 (EDT) Anthony Verevkin wrote:

> > From: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
> > To: "Alfredo Deza" <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > Sent: Monday, October 9, 2017 11:09:29 AM
> > Subject: [ceph-users] killing ceph-disk [was Re: ceph-volume: migration and disk partition support]
> > 
> > To put this in context, the goal here is to kill ceph-disk in mimic.
> >   
> 
>  
> > Perhaps the "out" here is to support a "dir" option where the user
> > can
> > manually provision and mount an OSD on /var/lib/ceph/osd/*, with
> > 'journal'
> > or 'block' symlinks, and ceph-volume will do the last bits that
> > initialize
> > the filestore or bluestore OSD from there.  Then if someone has a
> > scenario
> > that isn't captured by LVM (or whatever else we support) they can
> > always
> > do it manually?
> >   
> 
> 
> In fact, now that bluestore only requires a few small files and symlinks to remain in /var/lib/ceph/osd/* without the extra requirements for xattrs support and xfs, why not simply leave those folders on OS root filesystem and only point symlinks to bluestore block and db devices? That would simplify the osd deployment so much - and the symlinks can then point to /dev/disk/by-uuid or by-path or lvm path or whatever. The only downside for this approach that I see is that disks themselves would no longer be transferable between the hosts as those few files that describe the OSD are no longer on the disk itself.
> 

If the OS is on a RAID1 the chances of things being lost entirely is
reduced very much, so moving OSDs to another host becomes a trivial
exercise one would assume.

But yeah, this sounds fine to me, as it's extremely flexible.

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi-FW+hd8ioUD0@public.gmane.org   	Rakuten Communications
