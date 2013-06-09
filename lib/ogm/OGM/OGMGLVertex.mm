//
//  OGMVertex.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertex.h"

#import "OGMErrorUtil.h"

#define _NST(x) OGMGLVertexType##x

NSString * _NST(ToString)(_NST() type){
#define _CASE(x) case x : return @ #x
	switch(type){
			_CASE(_NST(None));
			_CASE(_NST(PC));
			_CASE(_NST(PCT));
			_CASE(_NST(PCN));
			_CASE(_NST(PCTN));
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown type: 0x%04x",type);
	}
#undef _CASE
}

size_t _NST(Size)(_NST() type){
#define _CASE(x) case x : return sizeof(x)
	switch(type){
			_CASE(_NST(None));
			_CASE(_NST(PC));
			_CASE(_NST(PCT));
			_CASE(_NST(PCN));
			_CASE(_NST(PCTN));
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown type: 0x%04x",type);
	}
#undef _CASE
}

BOOL _NST(HasUv)(_NST() type){
#define _CASE(x,r) case x : return r
	switch(type){
			_CASE(_NST(None),NO);
			_CASE(_NST(PC),NO);
			_CASE(_NST(PCT),YES);
			_CASE(_NST(PCN),NO);
			_CASE(_NST(PCTN),YES);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown type: 0x%04x",type);
	}
#undef _CASE
}
BOOL _NST(HasNormal)(_NST() type){
#define _CASE(x,r) case x : return r
	switch(type){
			_CASE(_NST(None),NO);
			_CASE(_NST(PC),NO);
			_CASE(_NST(PCT),NO);
			_CASE(_NST(PCN),YES);
			_CASE(_NST(PCTN),YES);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown type: 0x%04x",type);
	}
#undef _CASE
}

#undef _NST