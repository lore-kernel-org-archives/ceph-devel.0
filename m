From: Jack Culpepper <jackculpepper@gmail.com>
Subject: Re: users, 2.6.34
Date: Wed, 3 Mar 2010 14:45:31 -0800
Message-ID: <261c158e1003031445k54caafd7i25ff6d0c70586328@mail.gmail.com>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
	<20100303011014.f4fb95b3.ctpm@ist.utl.pt>
	<261c158e1003030027p71278f92h5a4abd82b5ab6d57@mail.gmail.com>
	<Pine.LNX.4.64.1003031355290.1006@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1003031355290.1006@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

> Yeah, the packages aren't signed by a trusted debian gpg key.

Ok.

>> Hmm, something's weird. No makefile! Also, the README has zero bytes.
>> [...]
>> Maybe a packaging goof?
>
> Yeah, I forgot to backport the debian/rules fix to the stable branch.
> I uploaded fixed packages.

Ok, trying again.. I get here now:

xyz# make
make -C /lib/modules/2.6.26-2-amd64/build M=/usr/src/modules/ceph
CONFIG_CEPH_FS=m modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.26-2-amd64'
  CC [M]  /usr/src/modules/ceph/crypto.o
/usr/src/modules/ceph/crypto.c:6:25: error: crypto/hash.h: No such
file or directory
/usr/src/modules/ceph/crypto.c: In function 'ceph_crypto_alloc_cipher':
/usr/src/modules/ceph/crypto.c:74: error: implicit declaration of
function 'crypto_alloc_blkcipher'
/usr/src/modules/ceph/crypto.c:74: error: 'CRYPTO_ALG_ASYNC'
undeclared (first use in this function)
/usr/src/modules/ceph/crypto.c:74: error: (Each undeclared identifier
is reported only once
/usr/src/modules/ceph/crypto.c:74: error: for each function it appears in.)
/usr/src/modules/ceph/crypto.c:74: warning: return makes pointer from
integer without a cast
/usr/src/modules/ceph/crypto.c: In function 'ceph_aes_encrypt':
/usr/src/modules/ceph/crypto.c:84: error: variable 'desc' has
initializer but incomplete type
/usr/src/modules/ceph/crypto.c:84: error: unknown field 'tfm'
specified in initializer
/usr/src/modules/ceph/crypto.c:84: warning: excess elements in struct
initializer
/usr/src/modules/ceph/crypto.c:84: warning: (near initialization for 'desc')
/usr/src/modules/ceph/crypto.c:84: error: unknown field 'flags'
specified in initializer
/usr/src/modules/ceph/crypto.c:84: warning: excess elements in struct
initializer
/usr/src/modules/ceph/crypto.c:84: warning: (near initialization for 'desc')
/usr/src/modules/ceph/crypto.c:84: error: storage size of 'desc' isn't known
/usr/src/modules/ceph/crypto.c:98: error: implicit declaration of
function 'crypto_blkcipher_setkey'
/usr/src/modules/ceph/crypto.c:104: error: implicit declaration of
function 'crypto_blkcipher_crt'
/usr/src/modules/ceph/crypto.c:104: error: invalid type argument of '->'
/usr/src/modules/ceph/crypto.c:105: error: implicit declaration of
function 'crypto_blkcipher_ivsize'
/usr/src/modules/ceph/crypto.c:116: error: implicit declaration of
function 'crypto_blkcipher_encrypt'
/usr/src/modules/ceph/crypto.c:118: error: implicit declaration of
function 'crypto_free_blkcipher'
/usr/src/modules/ceph/crypto.c:84: warning: unused variable 'desc'
/usr/src/modules/ceph/crypto.c: In function 'ceph_aes_encrypt2':
/usr/src/modules/ceph/crypto.c:134: error: variable 'desc' has
initializer but incomplete type
/usr/src/modules/ceph/crypto.c:134: error: unknown field 'tfm'
specified in initializer
/usr/src/modules/ceph/crypto.c:134: warning: excess elements in struct
initializer
/usr/src/modules/ceph/crypto.c:134: warning: (near initialization for 'desc')
/usr/src/modules/ceph/crypto.c:134: error: unknown field 'flags'
specified in initializer
/usr/src/modules/ceph/crypto.c:134: warning: excess elements in struct
initializer
/usr/src/modules/ceph/crypto.c:134: warning: (near initialization for 'desc')
/usr/src/modules/ceph/crypto.c:134: error: storage size of 'desc' isn't known
/usr/src/modules/ceph/crypto.c:155: error: invalid type argument of '->'
/usr/src/modules/ceph/crypto.c:134: warning: unused variable 'desc'
/usr/src/modules/ceph/crypto.c: In function 'ceph_aes_decrypt':
/usr/src/modules/ceph/crypto.c:186: error: variable 'desc' has
initializer but incomplete type
/usr/src/modules/ceph/crypto.c:186: error: unknown field 'tfm'
specified in initializer
/usr/src/modules/ceph/crypto.c:186: warning: excess elements in struct
initializer
/usr/src/modules/ceph/crypto.c:186: warning: (near initialization for 'desc')
/usr/src/modules/ceph/crypto.c:186: error: storage size of 'desc' isn't known
/usr/src/modules/ceph/crypto.c:203: error: invalid type argument of '->'
/usr/src/modules/ceph/crypto.c:215: error: implicit declaration of
function 'crypto_blkcipher_decrypt'
/usr/src/modules/ceph/crypto.c:186: warning: unused variable 'desc'
/usr/src/modules/ceph/crypto.c: In function 'ceph_aes_decrypt2':
/usr/src/modules/ceph/crypto.c:247: error: variable 'desc' has
initializer but incomplete type
/usr/src/modules/ceph/crypto.c:247: error: unknown field 'tfm'
specified in initializer
/usr/src/modules/ceph/crypto.c:247: warning: excess elements in struct
initializer
/usr/src/modules/ceph/crypto.c:247: warning: (near initialization for 'desc')
/usr/src/modules/ceph/crypto.c:247: error: storage size of 'desc' isn't known
/usr/src/modules/ceph/crypto.c:265: error: invalid type argument of '->'
/usr/src/modules/ceph/crypto.c:247: warning: unused variable 'desc'
make[2]: *** [/usr/src/modules/ceph/crypto.o] Error 1
make[1]: *** [_module_/usr/src/modules/ceph] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.26-2-amd64'
make: *** [all] Error 2
xyz# pwd
/usr/src/modules/ceph
xyz#

Should that be config/crypto/hash.h ?

xyz# find /usr/src/linux-headers-2.6.26-2-common -name hash.h
/usr/src/linux-headers-2.6.26-2-common/include/linux/hash.h
xyz# find /usr/src/linux-headers-2.6.26-2-amd64 -name hash.h
/usr/src/linux-headers-2.6.26-2-amd64/include/linux/hash.h
/usr/src/linux-headers-2.6.26-2-amd64/include/config/ip/fib/hash.h
/usr/src/linux-headers-2.6.26-2-amd64/include/config/crypto/hash.h
/usr/src/linux-headers-2.6.26-2-amd64/include/config/ask/ip/fib/hash.h
/usr/src/linux-headers-2.6.26-2-amd64/include/config/cifs/weak/pw/hash.h
xyz#

BTW, the fact that the configure script tells me which debian package
I need to install is really great.

> Did you ever try out the active object stuff?

I did not, but I will! I started dragging my feet a little.

I had originally hoped I could try just the active object stuff using
the beta hosted at DH. However, I will probably be more useful if I
set up my own system so I will do that. But I would still use the beta
if that's available too..

Jack

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
