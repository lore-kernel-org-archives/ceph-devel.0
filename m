From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Data still in OSD directories after removing
Date: Wed, 21 May 2014 08:20:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405210818560.1689@cobra.newdream.net>
References: <1400578369.11397.9.camel@localhost>
	<1400667430.27385.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1400667430.27385.4.camel@localhost>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Olivier Bonvalet <ceph.list-PaEMFeTk6C1QFI55V6+gNQ@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Olivier,

On Wed, 21 May 2014, Olivier Bonvalet wrote:
> Hi,
> 
> I have a lot of space wasted by this problem (about 10GB per OSD, just
> for this RBD image).
> If OSDs can't detect orphans files, should I manually detect them, then
> remove them ?
> 
> This command can do the job, at least for this image prefix :
>     find /var/lib/ceph/osd/ -name 'rb.0.14bfb5a.238e1f29.*' -delete

You should definitely not do this!  :)

You're certain that that is the correct prefix for the rbd image you 
removed?  Do you see the objects lists when you do 'rados -p rbd ls - | 
grep <prefix>'?

If the objects really are orphaned, teh way to clean them up is via 'rados 
-p rbd rm <objectname>'.  I'd like to get to the bottom of how they ended 
up that way first, though!

sage

> 
> Thanks for any advice,
> Olivier
> 
> PS : not sure if this kind of problem is for the user or dev mailing
> list.
> 
> Le mardi 20 mai 2014 ? 11:32 +0200, Olivier Bonvalet a ?crit :
> > Hi,
> > 
> > short : I removed a 1TB RBD image, but I still see files about it on
> > OSD.
> > 
> > 
> > long :
> > 1) I did : "rbd snap purge $pool/$img"
> >    but since it overload the cluster, I stopped it (CTRL+C)
> > 2) latter, "rbd snap purge $pool/$img"
> > 3) then, "rbd rm $pool/$img"
> > 
> > now, on the disk I can found files of this v1 RBD image (prefix was
> > rb.0.14bfb5a.238e1f29) :
> > 
> > # find /var/lib/ceph/osd/ceph-64/ -name 'rb.0.14bfb5a.238e1f29.*'
> > /var/lib/ceph/osd/ceph-64/current/9.5c1_head/DIR_1/DIR_C/DIR_5/DIR_3/rb.0.14bfb5a.238e1f29.000000021431__snapdir_C96635C1__9
> > /var/lib/ceph/osd/ceph-64/current/9.5c1_head/DIR_1/DIR_C/DIR_5/DIR_3/rb.0.14bfb5a.238e1f29.000000005622__a252_32F435C1__9
> > /var/lib/ceph/osd/ceph-64/current/9.5c1_head/DIR_1/DIR_C/DIR_5/DIR_3/rb.0.14bfb5a.238e1f29.000000021431__a252_C96635C1__9
> > /var/lib/ceph/osd/ceph-64/current/9.5c1_head/DIR_1/DIR_C/DIR_5/DIR_3/rb.0.14bfb5a.238e1f29.000000005622__snapdir_32F435C1__9
> > /var/lib/ceph/osd/ceph-64/current/9.5c1_head/DIR_1/DIR_C/DIR_5/DIR_9/rb.0.14bfb5a.238e1f29.000000011e08__a172_594495C1__9
> > /var/lib/ceph/osd/ceph-64/current/9.5c1_head/DIR_1/DIR_C/DIR_5/DIR_9/rb.0.14bfb5a.238e1f29.000000011e08__snapdir_594495C1__9
> > /var/lib/ceph/osd/ceph-64/current/9.5c1_head/DIR_1/DIR_C/DIR_5/DIR_A/rb.0.14bfb5a.238e1f29.000000021620__a252_779FA5C1__9
> > ...
> > 
> > 
> > So, is there a way to force OSD to detect if files are orphans, then
> > remove them ?
> > 
> > Thanks,
> > Olivier
> > 
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
