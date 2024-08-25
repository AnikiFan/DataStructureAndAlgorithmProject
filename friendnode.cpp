#include "friendnode.h"

FriendNode::FriendNode()
    :no{invalid},connectivity{0}
{
}

FriendNode::FriendNode(const long long number)
    :no{number},connectivity(invalid)
{

}

FriendNode::FriendNode(const long long number,  const long long connect)
    :no{number},connectivity{connect}
{

}
