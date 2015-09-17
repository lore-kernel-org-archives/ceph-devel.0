From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Important security noticed regarding release
	signing key
Date: Thu, 17 Sep 2015 11:19:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509171117540.31198@cobra.newdream.net>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
	<robbat2-20150917T173223-066349316Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <robbat2-20150917T173223-066349316Z-UgNl/1uUEYUufQK+DwRw3KxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Robin H. Johnson" <robbat2-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 17 Sep 2015, Robin H. Johnson wrote:
> On Thu, Sep 17, 2015 at 09:29:35AM -0700,  Sage Weil wrote:
> > Last week, Red Hat investigated an intrusion on the sites of both the Ceph 
> > community project (ceph.com) and Inktank (download.inktank.com), which 
> > were hosted on a computer system outside of Red Hat infrastructure.
> > 
> > Ceph.com provided Ceph community versions downloads signed with a Ceph 
> > signing key (id 7EBFDD5D17ED316D). Download.inktank.comprovided releases 
> > of the Red Hat Ceph product for Ubuntu and CentOS operating systems signed 
> > with an Inktank signing key (id 5438C7019DCEEEAD). While the investigation 
> > into the intrusion is ongoing, our initial focus was on the integrity of 
> > the software and distribution channel for both sites.
>
> Please revoke the old keys, so that if they were taken by the attacker,
> they cannot be used (you can't un-revoke a key generally).

Done:

	http://pgp.mit.edu/pks/lookup?search=ceph&op=index

sage
