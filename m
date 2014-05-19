From: David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: Ceph Plugin for Collectd
Date: Mon, 19 May 2014 21:45:50 +0100
Message-ID: <537A6D7E.4010400@cam.ac.uk>
References: <53736094.4060104@1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <53736094.4060104-JIpuZCKxcH8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Christian Eichelmann <christian.eichelmann-JIpuZCKxcH8@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 14/05/14 13:24, Christian Eichelmann wrote:
> Hi Ceph User!
> 
> I had a look at the "official" collectd fork for ceph, which is quite
> outdated and not compatible with the upstream version.
> 
> Since this was not an option for us, I've worte a Python Plugin for
> Collectd, that gets all the precious informations out of the admin
> sockets "perf dump" command. It runs on our productive cluster right now
> and I'd like to share it with you:
> 
> https://github.com/Crapworks/collectd-ceph
> 
> Any feedback is welcome!

Fun, I'd just implemented something very similar!

I've just pushed my version upstream to:

 https://github.com/dwm/collectd-ceph

There appear to be some minor differences between our designs:

 * I don't require that a types DB be kept up to date and consistent;
   rather, I've reused the generic 'counter' and 'gauge' types.

 * My version includes some historical processing to allow for the
   calculation of per-period, rather than global, average values.

 * Your version is nicer in that it communicates with the admin socket
   directly; I was lazy and simply invoked the `ceph` command-line tool
   to do that work for me.  It's not currently a significant
   performance hit, but should be improved.

I've been feeding all of my Ceph performance counter data to a Graphite
cluster via CollectD, using the CollectD AMQP plugin and a RabbitMQ
cluster as an intermediary, and Grafana as a query/graphing tool.

Apart from causing some stress on the disk-subsystem attempting to
write-out all those metrics, this has been working out quite well...

Cheers,
David
-- 
David McBride <dwm37-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Unix Specialist, University Information Services
