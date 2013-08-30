From: "Jimmy Lu [ Storage ]" <jlu-ZXvpkYn067l8UrSeD/g0lQ@public.gmane.org>
Subject: ceph install
Date: Fri, 30 Aug 2013 18:46:55 +0000
Message-ID: <CE4635EA.6E0D4%jlu@yahoo-inc.com>
References: <CAMNMNTyUucZ2ZZu_KwfX2mz77Zx45Lf1j9xRYRNDJWdgF1LkPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTyUucZ2ZZu_KwfX2mz77Zx45Lf1j9xRYRNDJWdgF1LkPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <E6BA20D9A5D8FA4BAD8444FB1E34129F-Un7Qja14ibOxRHTZ4l5qPBupM2+RrINj@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello ceph-users,

I am new to Ceph and would like to bring up a 5-node cluster for my PoC. I
am doing an installation from below link and ran into a problem. I am not
so sure how to deal with it. Can someone please shed some light?

http://ceph.com/docs/master/install/rpm/

[root@cleverloadgen16 ceph]# ceph auth add client.radosgw.gateway
--in-file=/etc/ceph/keyring.radosgw.gateway
unable to find any monitors in conf. please specify monitors via -m
monaddr or -c ceph.conf
Error connecting to cluster: ObjectNotFound

[root@cleverloadgen16 ceph]# cat keyring.radosgw.gateway
[client.radosgw.gateway]
	key = AQCC4yBSyMWQGBAADS7j7DnIZeGAZiaJFaM8Xw==
	caps mon = "allow rw"
	caps osd = "allow rwx"
[root@cleverloadgen16 ceph]#


Thanks,
jimmy
