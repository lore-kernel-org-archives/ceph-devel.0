From: "Marc Roos" <M.Roos-yG4tGvGIC004hcxptnrGZodd74u8MsAO@public.gmane.org>
Subject: Re: Show and Tell: Grafana cluster dashboard
Date: Mon, 7 May 2018 10:06:09 +0200
Message-ID: <8374.54902143708$1525699425@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, jfajerski <jfajerski-IBi9RG/b67k@public.gmane.org>
Cc: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


Looks nice 

- I rather have some dashboards with collectd/influxdb.
- Take into account bigger tv/screens eg 65" uhd. I am putting more 
stats on them than viewing them locally in a webbrowser.
- What is to be considered most important to have on your ceph 
dashboard? As a newbie I find it difficult to determine what is 
important to monitor.
- Maybe also some docs on what metrics you have taken and argumentation 
on how you used them (could be usefull if one wants to modify the 
dashboard for some other backend)

Ceph performance counters description.
https://access.redhat.com/documentation/en/red-hat-ceph-storage/1.3/paged/administration-guide/chapter-9-performance-counters


-----Original Message-----
From: Jan Fajerski [mailto:jfajerski-IBi9RG/b67k@public.gmane.org] 
Sent: maandag 7 mei 2018 12:32
To: ceph-devel
Cc: ceph-users
Subject: [ceph-users] Show and Tell: Grafana cluster dashboard

Hi all,
I'd like to request comments and feedback about a Grafana dashboard for 
Ceph cluster monitoring.

https://youtu.be/HJquM127wMY

https://github.com/ceph/ceph/pull/21850

The goal is to eventually have a set of default dashboards in the Ceph 
repository that offer decent monitoring for clusters of various (maybe 
even all) sizes and applications, or at least serve as a starting point 
for customizations.
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
