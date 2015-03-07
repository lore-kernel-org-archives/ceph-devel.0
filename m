From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Fwd:  Prioritize Heartbeat packets
Date: Fri, 6 Mar 2015 17:22:00 -0700
Message-ID: <CAANLjFpV0_2Xrr_+MtmPmLALPMBb70CmqxPFbFPf6MphusVmNA@mail.gmail.com>
References: <1985102496.575.1409186929716.JavaMail.root@thunderbeast.private.linuxbox.com>
	<alpine.DEB.2.00.1408271755160.966@cobra.newdream.net>
	<ltmnkp$tod$1@ger.gmane.org>
	<CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hidden HTML ... trying agin...

---------- Forwarded message ----------
From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Date: Fri, Mar 6, 2015 at 5:20 PM
Subject: Re: [ceph-users] Prioritize Heartbeat packets
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>,
ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


I see that Jian Wen has done work on this for 0.94. I tried looking
through the code to see if I can figure out how to configure this new
option, but it all went over my head pretty quick.

Can I get a brief summary on how to set the priority of heartbeat
packets or where to look in the code to figure it out?

Thanks,

On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick
<daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org> wrote:
>
> On 28/08/14 02:56, Sage Weil wrote:
> > I seem to remember someone telling me there were hooks/hints you could
> > call that would tag either a socket or possibly data on that socket with a
> > label for use by iptables and such.. but I forget what it was.
> >
>
> Something like setsockopt() SO_MARK?
>
>        *SO_MARK *(since Linux 2.6.25)
>               Set the mark for each packet sent through this socket (similar
>               to the netfilter MARK target but socket-based).  Changing the
>               mark can be used for mark-based routing without netfilter or
>               for packet filtering.  Setting this option requires the
>               *CAP_NET_ADMIN *capability.
>
> Alternatively, directly set IP_TOS options on the socket, or SO_PRIORITY
> which sets the IP TOS bits as well.
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
