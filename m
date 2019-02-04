From: Philippe Van Hecke <Philippe.VanHecke-58DTJjpCniqzQB+pC5nmwQ@public.gmane.org>
Subject: Re: Luminous cluster in very bad state need some
 assistance.
Date: Mon, 4 Feb 2019 06:27:53 +0000
Message-ID: <1549261672944.37241@belnet.be>
References: <d8faa6e9eaf146cb952a3dadba5c5343@EXCHLOU1.ad.fw.belnet.be>,
 <alpine.DEB.2.11.1902031716470.4436@piezo.novalocal>
 <1549259449109.740@belnet.be>
 <alpine.DEB.2.11.1902040556120.4436@piezo.novalocal>,
 <alpine.DEB.2.11.1902040617170.4436@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1902040617170.4436-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Belnet Services <services-58DTJjpCniqzQB+pC5nmwQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Sage,

Not during the network flap or before flap , but after i had already tried the 
ceph-objectstore-tool remove export with no possibility to do it.

And conf file never had the "ignore_les" option. I was even not aware of the existence of this option and seem that it preferable to forget that it inform me about it immediately :-)

Kr
Philippe.


On Mon, 4 Feb 2019, Sage Weil wrote:
> On Mon, 4 Feb 2019, Philippe Van Hecke wrote:
> > Hi Sage, First of all tanks for your help
> >
> > Please find here  https://filesender.belnet.be/?s=download&token=dea0edda-5b6a-4284-9ea1-c1fdf88b65e9

Something caused the version number on this PG to reset, from something
like 54146'56789376 to 67932'2.  Was there any operator intervention in
the cluster before or during the network flapping?  Or did someone by
chance set the (very dangerous!) ignore_les option in ceph.conf?

sage
