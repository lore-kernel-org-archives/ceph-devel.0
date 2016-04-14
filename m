From: "=?ISO-8859-15?Q?Steffen=20Wei=DFgerber?=" <WeissgerberS-Srp0Ujq4vxI@public.gmane.org>
Subject: Antw: Re:  Deprecating ext4 support
Date: Thu, 14 Apr 2016 11:43:07 +0200
Message-ID: <570F824B020000CD0002B110@mail.dbknb.de>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<20160412083925.5106311d@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20160412083925.5106311d-9yhXNL7Kh0lSCLKNlHTxZM8NsWr+9BEh@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: chibi-FW+hd8ioUD0@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org



>>> Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org> schrieb am Dienstag, 12. April 2016 um 01:39:

> Hello,
> 

Hi,

> I'm officially only allowed to do (preventative) maintenance during weekend
> nights on our main production cluster. 
> That would mean 13 ruined weekends at the realistic rate of 1 OSD per
> night, so you can see where my lack of enthusiasm for OSD recreation comes
> from.
> 

Wondering extremely about that. We introduced ceph for VM's on RBD to not
have to move maintenance time to night shift.

My understanding of ceph is that it was also made as reliable storage in case
of hardware failure.

So what's the difference between maintain an osd and it's failure in effect for
the end user? In both cases it should be none.

Maintaining OSD's should be routine so that you're confident that your application
stays save while hardware fails in a amount one configured unused reserve.

In the end what happens to your cluster, when a complete node fails?

Regards

Steffen

> 
> Christian
> -- 
> Christian Balzer        Network/Systems Engineer                
> chibi-FW+hd8ioUD0@public.gmane.org   	Global OnLine Japan/Rakuten Communications
> http://www.gol.com/ 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


-- 
Klinik-Service Neubrandenburg GmbH
Allendestr. 30, 17036 Neubrandenburg
Amtsgericht Neubrandenburg, HRB 2457
Geschaeftsfuehrerin: Gudrun Kappich
