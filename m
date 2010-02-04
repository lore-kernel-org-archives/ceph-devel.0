From: Sage Weil <sage@newdream.net>
Subject: Re: loadable object classes
Date: Thu, 4 Feb 2010 14:48:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002041437100.24705@cobra.newdream.net>
References: <261c158e1002041216u593cfef2vb82e4c65504a4af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <261c158e1002041216u593cfef2vb82e4c65504a4af@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Jack Culpepper <jackculpepper@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Jack!

On Thu, 4 Feb 2010, Jack Culpepper wrote:
> I am trying to understand the loadable class stuff, which seems really
> cool. I see the objclass directory and cls_crypto.cc seems to be a
> good example that I could copy and change around.
> 
> Does the code in cls_crypto.cc get linked into code at the storage node?

Yeah, the storage daemon will do a dlopen() to link in the .so.

> Is it run in userspace?

Yep.

> I see an exec() in librados.cc, and then testrados.c seems to be the
> place where I would add a driver program to call whatever class I add?

Right.
 
> You link to openssl for the crypto. Is it ok to link to other,
> possibly huge libraries?

Yeah, so long as you keep in mind it'll get loaded into all instances of 
the cosd storage daemon.

> On the test system, will there be a special place to store the
> libraries my class needs?

The system manages the library of loaded classes internally.  You load 
them into the system with something like

$ ./ceph class add crypto 1 x86-64 -i libcls_crypto.so

where 1 is the version, x86-64 is the arch.  (Note that it may take a few 
seconds for the classes to propagate to all nodes.)  If you have multiple 
versions loaded, you need to explicitly activate the version you want.  
See

$ ./ceph class list
$ ./ceph class activate crypto 2 

etc.

If you load the libcls_acl.so and libcls_crypto.so classes, testradospp 
will test them.

It's pretty rough around the edges (hasn't seen a lot of testing).  We're 
definitely interested in hearing how it works for you (in terms of the api 
and everything else)!

sage

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
