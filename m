From: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RBD image format v1 EOL ...
Date: Fri, 22 Feb 2019 16:38:36 +0200
Message-ID: <20190222143835.GA20829@gmail.com>
References: <CA+aFP1Dod_hwug_omfegFTERyiYmwa+3KDcBZsXcjR+B87YykQ@mail.gmail.com>
 <20190220092247.GZ92783@fi.muni.cz>
 <20190220153758.GA10288@gmail.com>
 <48f860e6-f9d4-ef39-53a2-465380596429@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48f860e6-f9d4-ef39-53a2-465380596429-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: koukou73gr <koukou73gr-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Feb 22, 2019 at 02:43:36PM +0200, koukou73gr wrote:
> On 2019-02-20 17:38, Mykola Golub wrote:
> 
> > Note, if even rbd supported live (without any downtime) migration you
> > would still need to restart the client after the upgrate to a new
> > librbd with migration support.
> > 
> > 
> You could probably get away with executing the client with a new librbd
> version by live migrating the VM to an updated hypervisor.
> 
> At least, this is what I have been doing so far when updating Ceph client
> libraries having zero downtime.

Yes, and this is what I meant when I was writing about investigating a
possiblilty to migrate to the new format with zero downtime by using
VM live migration. If there were a way to execute "rbd migration
prepare $pool/$image" during live VM migration, exactly after the
source VM closes the rbd image but before the destination VM opens it,
it would do the trick (the destination VM would start using the new
format).

Right now I don't know if it is possible at all, because I am not
familiar with VM migration, e.g. I don't know if it opens the image on
the destination before or after it closes it on the source.

-- 
Mykola Golub
