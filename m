From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: IRC channels now require registered and identified
 users
Date: Tue, 18 Dec 2018 11:11:45 +0000
Message-ID: <ce0a9512-e2cc-8eba-6c0e-226c8351bddf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

All,


Earlier this week our IRC channels were set to require users to be
registered and identified before being allowed to join a channel. This
looked like the most reasonable option to combat the onslaught of spam
bots we've been getting in the last weeks/months.

As of today, this is in effect for #ceph, #ceph-devel, #ceph-dashboard,
and #ceph-orchestrators.

If you are unable to join a channel because of this requirement, you
should first register your username with

  /msg nickserv register <password> <email>

and you'll be able to identify yourself with

  /msg nickserv identify <password>

please see [1] for more information on how to use OFTC's services.


  -Joao


[1] https://www.oftc.net/Services/
